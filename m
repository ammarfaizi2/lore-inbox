Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVDHGin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVDHGin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVDHGin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:38:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42439 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262703AbVDHGim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:38:42 -0400
Date: Fri, 08 Apr 2005 09:32:43 -0400
From: karthik <karthik.r@samsung.com>
Subject: accessing i2c-driver
To: linux-kernel@vger.kernel.org
Message-id: <200504080932.43962.karthik.r@samsung.com>
Organization: samsung
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


       i want to write an application to access the i2c-matroxfb driver. can 
anybody tell me how to start with ie if u r accessing a char driver similar 
to File ie first we have to opne the driver, then when we call read it call 
the  driver specific read etc.

        Likewise how can i write one application to check what is happening in 
i2c-matroxfb module. if anybody got anyidea regarding this please mail me.

Karthik
