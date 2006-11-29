Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967486AbWK2R3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967486AbWK2R3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967490AbWK2R3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:29:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29119 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967486AbWK2R3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:29:05 -0500
Date: Wed, 29 Nov 2006 17:34:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] Trivial cleanup in the PCI IDs for the CS5535
Message-ID: <20061129173445.4dd7735e@localhost.localdomain>
In-Reply-To: <20061129170516.GF23793@cosmic.amd.com>
References: <20061129170516.GF23793@cosmic.amd.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 10:05:16 -0700
"Jordan Crouse" <jordan.crouse@amd.com> wrote:

> Attached is a trivial patch that renames a poorly worded PCI ID 
> for the Geode GX and CS5535 companion chips.  The graphics processor
> and host bridge actually live in the northbridge on the integrated 
> processor, not in the companion chip.  

Acked-by: Alan Cox <alan@redhat.com>
