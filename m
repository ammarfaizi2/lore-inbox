Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVCaNDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVCaNDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCaNDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:03:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9702 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261415AbVCaNBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:01:04 -0500
Date: Thu, 31 Mar 2005 14:01:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: James Bottomley <jejb@steeleye.com>, Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: megaraid driver (proposed patch)
Message-ID: <20050331130101.GA16421@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thierry Vignaud <tvignaud@mandrakesoft.com>,
	James Bottomley <jejb@steeleye.com>,
	Bruno Cornec <Bruno.Cornec@hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20050325182252.GA4268@morley.grenoble.hp.com> <1111775992.5692.25.camel@mulgrave> <20050325184718.GA15215@infradead.org> <1111777477.5692.29.camel@mulgrave> <m2zmwk9dkt.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zmwk9dkt.fsf@vador.mandrakesoft.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - tg3 and bcm5700 totally overlap

bcm5700 isn't in the tree.

> - the same for e100 and eepro100, e1000 and eepro1000

there's no eepro1000

> - sata drivers ahci and ata_piix used to overlap too on a cople of
>   devices
> - b44 and bcm4400 totally overlap

bcm4000 isn't in the tree

