Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRC0QPx>; Tue, 27 Mar 2001 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRC0QPn>; Tue, 27 Mar 2001 11:15:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5773 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131375AbRC0QPh>;
	Tue, 27 Mar 2001 11:15:37 -0500
Message-ID: <3AC0BC80.DD6B2F4F@mandrakesoft.com>
Date: Tue, 27 Mar 2001 11:14:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Ingram <ingram@symsys.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Config bug? In 2.2.19 CONFIG_RTL8139 depends on CONFIG_EXPERIMENTAL
In-Reply-To: <Pine.LNX.4.21.0103271000490.21814-100000@maestro.symsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Ingram wrote:
> 
> In 2.2.19 CONFIG_RTL8139 depends on CONFIG_EXPERIMENTAL.  The RTL8139
> driver is not labelled as experimental.  Is this an error?

Yeah, add '(EXPERIMENTAL)' to the text.  Send a patch to Alan if you
want...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
