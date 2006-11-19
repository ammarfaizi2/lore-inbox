Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755253AbWKSJoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbWKSJoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 04:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbWKSJoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 04:44:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6585 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755253AbWKSJod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 04:44:33 -0500
Subject: Re: [-mm patch] remove
	drivers/pci/search.c:pci_find_device_reverse()
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@redhat.com>
In-Reply-To: <20061117115404.4bc87cf9.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061117142145.GX31879@stusta.de>  <20061117115404.4bc87cf9.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 19 Nov 2006 10:44:00 +0100
Message-Id: <1163929440.31358.477.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 11:54 -0800, Andrew Morton wrote:
> On Fri, 17 Nov 2006 15:21:45 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the no longer used pci_find_device_reverse().
> 
> But it is exported to modules.


and no module uses it ;)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

