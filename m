Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUI1LJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUI1LJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUI1LJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:09:23 -0400
Received: from [220.225.128.84] ([220.225.128.84]:54495 "HELO
	mail.gdatech.co.in") by vger.kernel.org with SMTP id S267375AbUI1LJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:09:16 -0400
From: Sudhakar <v.sudhakar@gdatech.co.in>
Organization: GDA Technologies
To: linux-kernel@vger.kernel.org
Subject: Reg IDE Driver
Date: Tue, 28 Sep 2004 16:46:24 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281646.25005.v.sudhakar@gdatech.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is the IDE driver in the kernel is generic ?

Whether it can support CF Interfaces to a processor which has bo IDE 
controller ?

For eg if a CF is connected to a local bus whether the ide driver in the 
kernel can access it ?

If any modifications are needed,what are they ?

I hope its only the IDE_BASE 

If not so please provide some more info

-- 
Thanks and Regards,
Sudhakar V

GDA Technologies Ltd.
http://www.gdatech.com
