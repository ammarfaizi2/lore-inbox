Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271333AbRIJRth>; Mon, 10 Sep 2001 13:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271344AbRIJRt2>; Mon, 10 Sep 2001 13:49:28 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:9664 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271333AbRIJRtS>;
	Mon, 10 Sep 2001 13:49:18 -0400
Date: Mon, 10 Sep 2001 18:49:37 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rik van Riel <riel@conectiva.com.br>,
        "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Developing code for ia64
Message-ID: <953687369.1000147777@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.33L.0109100956181.20670-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109100956181.20670-100000@duckman.distro.conect
 iva>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Our product contains a pre-compiled core object (IP protection :-\ )
>
> In that case, be prepared to take the burden for all
> linux kernel support from your users, since we'll just
> send them your way.
>
> Your email address has been saved, bug reporters about
> any intel binary only driver will be told to ask you.

Before you all jump so far down his throat you hit his
arse, he did say "Our product contains a pre-compiled
core object". He did not say that this was a kernel module,
or any other part of the kernel.

His question was whether you could bundle IA-64 and IA-32
code together in a single binary file (as far as I could
tell), which while probably off topic here, probably
does not require application of cattle prod at such a
voltage. Whilst binary modules are contentious, esp.
w.r.t. support, I have found noone yet (famous last
words) who has credibly suggested that distributing or
running binary-only applications on a GPL'd *OS* (libraries
being a separate issue) is against either the spirit or
the letter of the OS license. And as such of course
the reports of application bugs should not be on lkml.

--
Alex Bligh
