Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVDIG2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVDIG2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 02:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVDIG2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 02:28:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:57421 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S261296AbVDIG2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 02:28:11 -0400
Date: Sat, 09 Apr 2005 09:55:20 -0400
From: karthik <karthik.r@samsung.com>
Subject: How to compile a single module in linux kernel tree (2.6 kernel)
To: linux-kernel@vger.kernel.org
Message-id: <200504090955.20266.karthik.r@samsung.com>
Organization: samsung
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

         Is it possible to compile a single module in the kernel souce and 
load it. if then the how to do it.

         Actually i tried to compile the mga driver in the kernel by giving 
the command 
         make mga
    but it didnt compiled showing many errors like 
undefined reference to__this_module 
undefined rreference to printk 
etc

        so please tell me how to comiple a single module or driver in 2.6 
kernel.

Karthik
