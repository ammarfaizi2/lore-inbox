Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312065AbSCTT0x>; Wed, 20 Mar 2002 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312071AbSCTT0n>; Wed, 20 Mar 2002 14:26:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312054AbSCTT0b>;
	Wed, 20 Mar 2002 14:26:31 -0500
Message-ID: <3C98E237.6020002@mandrakesoft.com>
Date: Wed, 20 Mar 2002 14:25:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Linux kernel 2.4.19-pre3-jg1
Content-Type: multipart/mixed;
 boundary="------------090609050401020301040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609050401020301040102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.19/misc-2.4.19.3-1.patch.bz2

NOTE!  This patch includes Marcelo's latest BK stuff, post-2.4.19-pre3, 
as well as my own merges.

Changeset (excluding Marcelo's BK changesets) and pull info follow.


--------------090609050401020301040102
Content-Type: text/plain;
 name="misc-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.4.txt"

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


--------------090609050401020301040102--

