Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbTABRZG>; Thu, 2 Jan 2003 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTABRZF>; Thu, 2 Jan 2003 12:25:05 -0500
Received: from c0ns0le.net.ttu.edu ([129.118.3.155]:36993 "EHLO
	c0ns0le.net.ttu.edu") by vger.kernel.org with ESMTP
	id <S266203AbTABRZC>; Thu, 2 Jan 2003 12:25:02 -0500
Date: Thu, 2 Jan 2003 11:33:15 -0600
Message-Id: <200301021733.h02HXFwn013814@c0ns0le.net.ttu.edu>
From: root@micr0s0ftsux.com
Subject: vanilla 2.4.20/2.4.21 doesn't boot w/ http://www.ecs.com.tw/products/pd_spec.asp?product_id=63  (L7VTARAID). vt8235 kt400(vt8377) pdc20265
To: linux-kernel@vger.kernel.org
X-Originating-IP: 129.118.3.141
X-Mailer: Webmin 1.050
X-Priority: 1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1041528795"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--bound1041528795
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

recently purchased the following mobo and have been trying multiple combinations of kernels/patches to try and get this working correctly. currently having to use a redhat 2.4.20-2.2.rpm to get the box to boot correctly yet it lacks xfs support. i'm needing to know if anyone has been able to get this combination of devices working correctly. if you need more info please reply directly as well as cc.. thanks

http://www.ecs.com.tw/products/pd_spec.asp?product_id=63

vanilla 2.4.20: system will detect the devices and halts after VP_IDE ide1
vanilla 2.4.21pre2: system will detect the devices and halts with dma_proxy_timeout:dma_status=0x64


thanks in advance for any input. 

brandon

--bound1041528795--
