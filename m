Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUFWUMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUFWUMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUFWUMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:12:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266656AbUFWUMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:12:08 -0400
Message-ID: <40D9E40A.8090906@pobox.com>
Date: Wed, 23 Jun 2004 16:11:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
CC: andersen@codepoet.org
Subject: [RFT] ICH5 SATA in latest 2.6-bk snapshot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The libata update in the latest -bk snapshot has updated interrupt 
acknowledgement code, that may address the problems some were seeing 
with an abnormally high amount of interrupts.


