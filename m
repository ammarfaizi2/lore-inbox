Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTFBWBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTFBWBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:01:05 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:42731 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S264173AbTFBWBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:01:05 -0400
Message-ID: <3EDBCC44.8000009@attbi.com>
Date: Mon, 02 Jun 2003 15:14:28 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70-bk7 -- drivers/net/irda/w83977af_ir.ko needs unknown symbol
 setup_dma
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70-bk7; fi
WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/w83977af_ir.ko 
needs unknown symbol setup_dma
WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/ali-ircc.ko 
needs unknown symbol setup_dma
WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/nsc-ircc.ko 
needs unknown symbol setup_dma
WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/smsc-ircc2.ko 
needs unknown symbol setup_dma


