Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290718AbSBLBgq>; Mon, 11 Feb 2002 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290708AbSBLBg3>; Mon, 11 Feb 2002 20:36:29 -0500
Received: from [208.179.59.195] ([208.179.59.195]:4474 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S290710AbSBLBgJ>; Mon, 11 Feb 2002 20:36:09 -0500
Message-ID: <3C687178.6010309@blue-labs.org>
Date: Mon, 11 Feb 2002 20:35:52 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel config core dump w/ bad input
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SYM53C8XX Version 2 SCSI support (CONFIG_SCSI_SYM53C8XX_2) [N/y/m/?] (NEW) y
  DMA addressing mode (CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE) [1] 
(NEW) y
scripts/Configure: line 245: 14353 Segmentation fault      (core dumped) 
expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1

I got ahead of myself hitting 'y'.

This is on 2.4.18-pre9

-d


