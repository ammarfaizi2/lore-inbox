Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWDNQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDNQUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDNQUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:20:15 -0400
Received: from isilmar.linta.de ([213.239.214.66]:53189 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751264AbWDNQUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:20:14 -0400
Date: Fri, 14 Apr 2006 18:20:12 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pcmcia@lists.infradead.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards
Message-ID: <20060414162012.GA19179@isilmar.linta.de>
Mail-Followup-To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pcmcia@lists.infradead.org,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 05:42:13PM +0200, Daniel Ritz wrote:
> [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards

Applied to pcmcia-git, thanks.

	Dominik
