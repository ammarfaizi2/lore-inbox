Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751892AbWFWSZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWFWSZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWFWSZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:25:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751892AbWFWSZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:25:43 -0400
Subject: Re: [GIT PATCH] Geode patches for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       akpm@osdl.org
In-Reply-To: <20060623170058.GA12819@cosmic.amd.com>
References: <20060623170058.GA12819@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 19:41:09 +0100
Message-Id: <1151088069.4549.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 11:00 -0600, ysgrifennodd Jordan Crouse:
>       Add a configuration option to avoid automatically probing VGA

Can you not do this automatically using the DMI data or PCI subvendor
id ?

