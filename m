Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSBNF5Z>; Thu, 14 Feb 2002 00:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNF5P>; Thu, 14 Feb 2002 00:57:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26125 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289775AbSBNF5F>;
	Thu, 14 Feb 2002 00:57:05 -0500
Message-ID: <3C6B51AA.6EB614C3@mandrakesoft.com>
Date: Thu, 14 Feb 2002 00:56:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
CC: lkcd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: status of LKCD into Linux Kernel
In-Reply-To: <20020214114457A.hyoshiok@miraclelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiro Yoshioka wrote:
> I have a naive question. Will the LKCD be merged into
> the Linus' kernel? If yes, when? wild guess?

I talked with Matt Robinson(sp?) at LinuxWorld-NY about LKCD for a few
minutes...  he gave me the impression that a lot of progress has been
made recently.  IBM apparently has some guys working on it, too.

I've always thought Linux needs industrial strength crash dumps like the
other Unices.  There are many benefits, but my own is self interest: 
bug reports get 1000 times better, since you get along with the crash
point a lot more info about the state of the system at the time of the
crash.

So, I hope LKCD is looked upon favorably by the Penguin Gods. :)

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
