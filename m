Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135697AbRDXRzg>; Tue, 24 Apr 2001 13:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135701AbRDXRz0>; Tue, 24 Apr 2001 13:55:26 -0400
Received: from armitage.toyota.com ([63.87.74.3]:25098 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S135697AbRDXRzV>; Tue, 24 Apr 2001 13:55:21 -0400
Message-ID: <3AE5BE02.B347F1AD@lexus.com>
Date: Tue, 24 Apr 2001 10:55:14 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.id>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:

> hi,
>
> a friend of my asked me on how to make linux easier to use
> for personal/casual win user.
>
>
> from that, i also found out that it is very awkward to type
> username and password every time i use my computer.
> so here's a patch.

Neet hack, but maybe the kernel isn't the best
place to do this -

For instance, you can simply use the KDE 2.1.1 login
manager, with the current kernel intact, to automatically
log in and start the X session of a specific user, upon
entering runlevel 5 -

Might this not be a better direction?

cu

jjs

