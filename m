Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRLTJeY>; Thu, 20 Dec 2001 04:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282823AbRLTJeO>; Thu, 20 Dec 2001 04:34:14 -0500
Received: from olinz-dsl-1316.utaonline.at ([212.152.239.38]:41455 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S282815AbRLTJeH>;
	Thu, 20 Dec 2001 04:34:07 -0500
Message-ID: <3C21AE53.F0CF0F20@falke.mail>
Date: Thu, 20 Dec 2001 10:24:35 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: xpert@XFree86.Org, linux-kernel@vger.kernel.org
Subject: Re: SiS 630 - framebuffer fixed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: tw@webit.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again.

After a few feedbacks on the framebuffer driver, I will do the
following:

1) For testing reasons, I will include my BIOS in the driver code. 

The reason for this is that I saw that the machines in question partly
have old video BIOSes (mine has a 2.xx.x while I saw one guy with
1.06.x; that old BIOS isn't even detected as a VESA BIOS).

By this measure, I will be able to estimate whether or not the whole
matter is actually BIOS related or not. If it is, you all may get
lucky...!

I am aware that this is no permanent solution for copyright reasons, but
for testing it will do.

2) Further, I will include code to write the video BIOS of a machine to
disk. All people testing this are being asked to send that file to me
then. 

Unfortunately, I have to work today, so don't count on a new version
today.

Thomas

PS: To all people testing the driver (or the X driver): Please send me
the logs! Some of you actually forgot to do that....

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:
mailto:tw@webit.com              http://www.webit.com/tw

