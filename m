Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966369AbWKNV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966369AbWKNV2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966367AbWKNV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:28:44 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:52419 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S966369AbWKNV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:28:42 -0500
Date: Tue, 14 Nov 2006 13:28:38 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: driver support for Chelsio T210 10Gb ethernet in 2.6.x
Message-ID: <Pine.LNX.4.64.0611131408010.32659@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The in-kernel Chelsio cxgb driver in 2.6.19-rc5 is version 2.1.1 and only 
supports the N110 and N210 10Gb ethernet boards.  The current driver 
available from Chelsio[1] is 2.1.4a and supports the T110 and T210 series 
boards, but is only available against 2.6.16.  Any chance of an update to 
the in-kernel driver for 2.6.20 to support the T* series cards?

-Chris

1. http://service.chelsio.com/drivers/linux/n210/cxgb-2.1.4a.tar.gz
