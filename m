Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRFFUck>; Wed, 6 Jun 2001 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRFFUca>; Wed, 6 Jun 2001 16:32:30 -0400
Received: from web10001.mail.yahoo.com ([216.136.130.37]:59659 "HELO
	web10001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261198AbRFFUcM>; Wed, 6 Jun 2001 16:32:12 -0400
Message-ID: <20010606203210.79319.qmail@web10001.mail.yahoo.com>
Date: Wed, 6 Jun 2001 13:32:10 -0700 (PDT)
From: Ali Sanaie <asanaie@yahoo.com>
Subject: RE:  Problem: NIC doesn't work anymore  Winbond 89C940
To: jonathan_brugge@hotmail.com, david@fortyoz.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have the same problem with my network card Winbond 89C940 on a
linksys etherPCI lan card II.

The kernel recommends ne2k-pci for winbond, It's detected by the kernel but I 
get the "bogus packet size" error and it does not send any info!
my kernel is 2.4.5 and RH7.1 is the system.

which driver did you use?

Thanks in advance
Ali



>From: David Raufeisen <david@fortyoz.org>
>Reply-To: David Raufeisen <david@fortyoz.org>
>To: Jonathan Brugge <jonathan_brugge@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Problem: NIC doesn't work anymore, SIOCIFADDR-errors
>Date: Wed, 14 Feb 2001 06:36:20 -0800
>
>Are you using the net-tools from debian? There was a broken one causing 
>these
>errors the last few days, is fixed now.
>
>On Wednesday, 14 February 2001, at 15:17:09 (+0100),
>Jonathan Brugge wrote:
>
> > Here's the output from dmesg, after deleting some unimportant stuff like
> > sound and graphics-init. I don't see any errors that have something to

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
