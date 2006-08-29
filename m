Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWH2Uqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWH2Uqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWH2Uqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:46:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21900 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965303AbWH2Uqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:46:33 -0400
Message-ID: <44F4A7A8.8050402@garzik.org>
Date: Tue, 29 Aug 2006 16:46:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Valerie Henson <val_henson@linux.intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 08/10] [TULIP] Handle pci_enable_device() errors in resume
References: <20060826000227.818796000@linux.intel.com> <20060826000304.251263000@linux.intel.com>
In-Reply-To: <20060826000304.251263000@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ditto Alan's comments, particularly exiting w/out unlocking

