Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRDUPsR>; Sat, 21 Apr 2001 11:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDUPsH>; Sat, 21 Apr 2001 11:48:07 -0400
Received: from B13b0.pppool.de ([213.7.19.176]:16909 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S132708AbRDUPrs>;
	Sat, 21 Apr 2001 11:47:48 -0400
Message-Id: <200104211546.f3LFknU08200@susi.maya.org>
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: 2.4.3ac11: [drm:r128_do_wait_for_idle] *ERROR* r128_do_wait_for_idle failed!
Date: Sat, 21 Apr 2001 17:46:48 +0200
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo world!

I don't know, if I'm here at the right mailinglist, but I found another 
posting for this problem right here, so I decided to post this additional 
question here too.

I'm using kernel 2.4.3ac11 (or previous) and actual DRI-sources from 
dri.sourceforge.net with an ATI EXPERT2000 graphic accelerator (Rage 128). My 
motherboard has the VIA686a (VIA KX133)-chipset with an Athlon 800MHz 
processor.

The acceleration seems to be working fine so far but I often get the 
errormessage which I wrote in the subject.
Another message I often get, is the following:
[drm:r128_do_wait_for_fifo] *ERROR* r128_do_wait_for_fifo failed!

I found the posting from Anton Blanchard (subject: Re: uniteruptable sleep) 
here in this mailinglist and I checked his suggestion. I found, that the 
changes he proposed, have been already implemented in the CVS-source-code of 
DRI - but the problem still exists.

Is the problem sitting 50 cm before the screen - or is it a bug?


Thank you very much for your great work and your advice
Regards,
Andreas Hartmann
