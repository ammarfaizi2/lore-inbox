Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293698AbSCAI4s>; Fri, 1 Mar 2002 03:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310345AbSCAIyo>; Fri, 1 Mar 2002 03:54:44 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:29190 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S310420AbSCAIx5>; Fri, 1 Mar 2002 03:53:57 -0500
Message-ID: <3C7F4080.7060802@megapathdsl.net>
Date: Fri, 01 Mar 2002 00:49:04 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020217
X-Accept-Language: en-us
MIME-Version: 1.0
To: davej@suse.de, linux-kernel@vger.kernel.org
Subject: 2.5.6-pre2 -- video1394.o -- depmod:  virt_to_bus_not_defined_use_pci_map
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, do you have a fix for this in your tree?

depmod: *** Unresolved symbols in 
/lib/modules/2.5.6-pre2/kernel/drivers/ieee1394/video1394.o
depmod: 	virt_to_bus_not_defined_use_pci_map

