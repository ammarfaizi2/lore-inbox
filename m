Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbRFSQ1i>; Tue, 19 Jun 2001 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264397AbRFSQ12>; Tue, 19 Jun 2001 12:27:28 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:51675 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263211AbRFSQ1S>; Tue, 19 Jun 2001 12:27:18 -0400
Message-ID: <3B2F7D30.4DE87953@wanadoo.fr>
Date: Tue, 19 Jun 2001 18:26:24 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.10-pre4, error while applying the patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While I apply the patch pre-patch-2.2.20-4 to a clean 2.2.19 tree, I get
the following error :

patching file `drivers/scsi/sd_ioctl.c'
patching file `drivers/scsi/sym53c8xx.c'
patching file `drivers/scsi/sym53c8xx_defs.h'
The next patch would create the file `drivers/sound/ad1848.c',
which already exists!  Assume -R? [n]


-----
Regards
		Jean-Luc
