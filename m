Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTFCSbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFCSbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:31:50 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:62409 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262135AbTFCSbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:31:49 -0400
Message-Id: <5.1.0.14.2.20030603204118.00a04728@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Jun 2003 20:45:04 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.21-rc7
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: ZYigtmZv8e5FTrjAVFM+XhRVrLynNk8KddLQrDuA7V-IulPElliusO@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21-rc7; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc7/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

Margit

