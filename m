Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUIOLei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUIOLei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUIOLeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:34:37 -0400
Received: from web53601.mail.yahoo.com ([206.190.37.34]:1464 "HELO
	web53601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265196AbUIOLee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:34:34 -0400
Message-ID: <20040915113434.80150.qmail@web53601.mail.yahoo.com>
Date: Wed, 15 Sep 2004 04:34:34 -0700 (PDT)
From: Donald Duckie <schipperke2000@yahoo.com>
Subject: snull_load insmod: unresolved symbol 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

has anyone ever tried compiling and running snull on
Linux2.4.18-sh?

i tried compiling snull(without any modification) on
Linux2.4.18-sh.
upon running snull_load, i got the following:
Using /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
insmod: unresolved symbol kmalloc_R93d4cfe6
insmod: unresolved symbol skb_under_panic_R69955398
insmod: unresolved symbol register_netdev_R09e03f58
insmod: unresolved symbol eth_type_trans_R0a4e7a1c
insmod: unresolved symbol unregister_netdev_R98eda3f8
insmod: unresolved symbol printk_Rdd132261
insmod: unresolved symbol __udivsi3_i4
insmod: unresolved symbol memcpy_R11f7ce5e
insmod: unresolved symbol jiffies_R0da02d67
insmod: unresolved symbol alloc_skb_R0177038c
insmod: unresolved symbol softnet_data_R258cb892
insmod: unresolved symbol cpu_raise_softirq_R4d09166c
insmod: unresolved symbol __kfree_skb_R1741771d
insmod: unresolved symbol memset_R2bc95bd4
insmod: unresolved symbol kfree_R037a0cba
insmod: unresolved symbol netif_rx_R8316ccd0
insmod: unresolved symbol ether_setup_R586ea93a
insmod: unresolved symbol skb_over_panic_R4bb59969

can someone please tell me what's wrong with this,
and how to fix this without chaning Linux versions?


thank you for you help in advance :-)



-
donald


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
