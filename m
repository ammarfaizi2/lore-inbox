Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269282AbTCBT2c>; Sun, 2 Mar 2003 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269283AbTCBT2b>; Sun, 2 Mar 2003 14:28:31 -0500
Received: from smtp01.web.de ([217.72.192.180]:3353 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S269282AbTCBT23>;
	Sun, 2 Mar 2003 14:28:29 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Hanasaki JiJi <hanasaki@hanaden.com>
Subject: Re: Kernel 2.4.20 ide-scsi
Date: Sun, 2 Mar 2003 20:38:53 +0000
User-Agent: KMail/1.5
References: <3E625282.8010101@hanaden.com>
In-Reply-To: <3E625282.8010101@hanaden.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303022038.53606.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_BLK_DEV_IDECD=y

seems, that you have made the same mistake like me yesterday.
(Thanks to Brian Davis again)

Just disable CONFIG_BLK_DEV_IDECD and try if it works.

bye, Michael Buesch.
