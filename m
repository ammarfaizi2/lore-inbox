Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbTGLOGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbTGLOGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:06:14 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:14993 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S265778AbTGLOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:06:13 -0400
Date: Sat, 12 Jul 2003 16:20:20 +0200
To: linux-kernel@vger.kernel.org
Subject: Problems with nforce IDE in 2.4.22-pre5
Message-ID: <20030712142020.GB3240@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19bLEa-0000rf-00*7pZROf9Vwg2* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    hy,

the second error ;-). With Kernel 2.4.22-pre5 I get this error:


hda: dma_timer_expiry: dma status == 0x64
hda: DMA interrupt recovery
hda: lost interrupt


Chipset: Nvidia NFORCE2
Harddisk: IBM IC35L080AVVA07-A ( 75 GB)

Kernel Options:

CONFIG_BLK_DEV_AMD74XX=Y
CONFIG_AMD74XX_OVERRIDE=Y

It was runnig fine on 2.4.22-pre2.


        thx for help

            Ruben
    
-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
