Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423720AbWJaR5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423720AbWJaR5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423717AbWJaR5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:57:40 -0500
Received: from isilmar.linta.de ([213.239.214.66]:13250 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1423720AbWJaR5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:57:39 -0500
Date: Tue, 31 Oct 2006 12:55:14 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] add WEIDA microdrive into ide-cs.c
Message-ID: <20061031175514.GA8987@dominikbrodowski.de>
Mail-Followup-To: Marcin Juszkiewicz <openembedded@hrw.one.pl>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	linux-pcmcia@lists.infradead.org
References: <200610302228.10043.openembedded@hrw.one.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610302228.10043.openembedded@hrw.one.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 30, 2006 at 10:28:09PM +0100, Marcin Juszkiewicz wrote:
> From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
> 
> Microdrive reported by one of OpenEmbedded developers.
> 
> product info: "WEIDA", "TWTTI", ""
> manfid: 0x000a, 0x0000
> function: 4 (fixed disk)
> 
> Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Thanks, applied to pcmcia-2.6.git (plus equivalent change to pata_pcmcia.c)

	Dominik
