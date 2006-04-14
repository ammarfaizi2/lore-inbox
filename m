Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWDNVDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWDNVDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWDNVC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:02:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:58284 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965163AbWDNVC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:02:59 -0400
Subject: Re: [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus
	cards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       linux-pcmcia@lists.infradead.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060414162012.GA19179@isilmar.linta.de>
References: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
	 <20060414162012.GA19179@isilmar.linta.de>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 06:59:42 +1000
Message-Id: <1145048382.4223.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 18:20 +0200, Dominik Brodowski wrote:
> On Fri, Apr 14, 2006 at 05:42:13PM +0200, Daniel Ritz wrote:
> > [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards
> 
> Applied to pcmcia-git, thanks.

Thanks. Dominik, can you make sure this hits upstream before 2.6.17 ?

Cheers,
Ben.


