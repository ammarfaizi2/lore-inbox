Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbRFXWKu>; Sun, 24 Jun 2001 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264826AbRFXWKk>; Sun, 24 Jun 2001 18:10:40 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:49158 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S264825AbRFXWK0>; Sun, 24 Jun 2001 18:10:26 -0400
Date: Mon, 25 Jun 2001 06:11:10 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Nilsson <pzycrow@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <E15EHkU-0000Wu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106250601370.204-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Alan Cox wrote:

> > 8: A way to change kernel without rebooting. I have no diskdrive or cddrive
> > in my laptop so I often do drastic things when I install a new distribution.
>
> Thats actually an incredibly hard problem to solve. The only people who do
> this level of stuff are some of the telephony folks, and the expensive
> tandem non-stop boxes.

I use loadlin + initrd on my Toshiba and Ibm notebook. Boot up dos first,
then to either a test linux or stable linux environment from the C drive.
I setup a Menu in config.sys under dos to select which linux to boot up.
If the test kernel doesn't work, I reboot the system to switch to the
stable one. At least better than carrying a floppy around.

ps. Alan, thanks for replying to my "reiserfs replay" question.

Jeff

