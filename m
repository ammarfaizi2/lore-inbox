Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUGIJoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUGIJoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUGIJoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:44:30 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:58510 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264685AbUGIJoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:44:22 -0400
Subject: Re: Removal of MCI Bluetooth USB dongle causes hci_hcd Ooop and
	unusability of part of USB bus...
From: Marcel Holtmann <marcel@holtmann.org>
To: Marian Stepka <mstepka@orangemail.sk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089359901.3568.23.camel@imro.intranet.orange.sk>
References: <1089359901.3568.23.camel@imro.intranet.orange.sk>
Content-Type: text/plain
Message-Id: <1089366245.4857.73.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 11:44:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marian,

> Removal of MCI Bluetooth USB dongle causes hci_hcd Ooop and unusability
> of part of USB bus...

update your kernel to 2.6.7 and this problem should be gone.

Regards

Marcel


