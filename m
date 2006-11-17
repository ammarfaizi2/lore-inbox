Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933613AbWKQOd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933613AbWKQOd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933623AbWKQOd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:33:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933613AbWKQOd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:33:56 -0500
Date: Fri, 17 Nov 2006 09:32:36 -0500
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
Subject: Re: [-mm patch] remove drivers/pci/search.c:pci_find_device_reverse()
Message-ID: <20061117143236.GA23210@devserv.devel.redhat.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117142145.GX31879@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 03:21:45PM +0100, Adrian Bunk wrote:
> This patch removes the no longer used pci_find_device_reverse().
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Alan Cox <alan@redhat.com>

Soon we should deprecate pci_find_device as well
