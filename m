Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRLNXbd>; Fri, 14 Dec 2001 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280686AbRLNXbW>; Fri, 14 Dec 2001 18:31:22 -0500
Received: from chmls20.mediaone.net ([24.147.1.156]:28607 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S280638AbRLNXbL>; Fri, 14 Dec 2001 18:31:11 -0500
Subject: Problems downgrading from Kernel 2.4.8 to 2.2.20
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Dec 2001 18:34:09 -0500
Message-Id: <1008372849.273.8.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to downgrade, to see if an issue with the 2.4.x series
kernel is also present in the 2.2.x series. I have successfully
downloaded, compiled and installed a 2.2.20 kernel and added the
necessary lines to lilo in order to have it as an option and to boot
into the same root partition as the 2.4.8 uses.

I am getting an error when I boot up 2.2.20. Right after the partition
check it says this:
Invalid session number or type of track
hda: lost interrupt

and keeps repeating hda: lost interrupt once every ten seconds or so
until I reboot. 2.4.8 boots up just fine. I've done a search of the
unofficial archives and only found solutions to problems regarding CD
images and such.

Does anyone know what the problem is, and can anyone give me some help?
Is it even possible to downgrade like this?

Thanks.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

