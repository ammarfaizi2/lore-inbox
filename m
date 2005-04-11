Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVDKDVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDKDVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVDKDVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:21:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64748 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261674AbVDKDVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:21:38 -0400
Date: Mon, 11 Apr 2005 06:48:35 -0400
From: karthik <karthik.r@samsung.com>
Subject: How to access a kernel module function
To: linux-kernel@vger.kernel.org
Message-id: <200504110648.35858.karthik.r@samsung.com>
Organization: samsung
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

          If i am writing a module and after compilation i am loading it. 
After that suppose i want to access few of the funtions in the module then 
how is it possible(i am not creating a device using mknode for the module).


             is it necessary that to access a kernel module function  we need 
to create a node or device. if its not necessary then how can i access my 
module's function from user program.

Karthik
