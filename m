Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293544AbSCUIQR>; Thu, 21 Mar 2002 03:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293552AbSCUIQI>; Thu, 21 Mar 2002 03:16:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293544AbSCUIPz>;
	Thu, 21 Mar 2002 03:15:55 -0500
Message-ID: <3C999684.4070904@mandrakesoft.com>
Date: Thu, 21 Mar 2002 03:15:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Linux kernel misc-2.4.19-pre4-jg1
Content-Type: multipart/mixed;
 boundary="------------080108070404000101060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080108070404000101060501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No changes, just rediffed.  Substantially smaller now that the latest
Marcelo changes are in pre4.

Patch at:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.19/misc-2.4.19.4-1.patch.gz

Changeset and pull info below.



--------------080108070404000101060501
Content-Type: text/plain;
 name="misc-2.4.19.4-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.4.19.4-1.txt"

Marcelo and other BK users, please do a

	bk pull http://gkernel.bkbits.net/misc-2.4

This will update the following files:

 drivers/net/wan/comx-hw-munich.c |   32 ++++++++++----------------------
 drivers/sound/ac97_codec.c       |    2 ++
 2 files changed, 12 insertions(+), 22 deletions(-)

through these ChangeSets:

<silicon@falcon.sch.bme.hu> (02/03/20 1.223)
   Update munich WAN driver to not kfree memory multiple times.

<jgarzik@mandrakesoft.com> (02/03/20 1.222)
   Add two AC97 codec ids to the OSS ac97_codec driver.
   
   Contributor: Peter Christy



--------------080108070404000101060501--

