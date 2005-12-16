Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVLPInq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVLPInq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVLPInp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:43:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932190AbVLPInp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:43:45 -0500
Date: Fri, 16 Dec 2005 08:43:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] I2O: SPARC fixes
Message-ID: <20051216084340.GA17814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <43A20A89.4060904@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A20A89.4060904@shadowconnect.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:30:01AM +0100, Markus Lidel wrote:
> Changes:
> --------
> - Fixed lot of BE <-> LE bugs which prevent it from working on SPARC.

this doesn't match the patch, which introduces a config option aswell.
