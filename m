Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWFLUyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWFLUyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWFLUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:54:36 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:1254 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751118AbWFLUyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:54:35 -0400
Date: Mon, 12 Jun 2006 21:54:34 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: VMSPLIT kernel config option
Message-ID: <20060612215434.0b8c873f@alpha.digital-domain.net>
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it meant, that the VMSPLIT_* options are only enabled 
"if EMBEDDED"?

See line 470 of arch/i386/Kconfig

This is with 2.6.17-rc6-git4


Cheers

Andrew
