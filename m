Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVAXMMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVAXMMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVAXMM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:12:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25475 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261274AbVAXMM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:12:27 -0500
Date: Mon, 24 Jan 2005 12:12:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124121226.GA29098@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +i4l-new-hfc_usb-driver-version.patch

this drivers wants:

 - update for Documentation/CodingStyle
 - conversion to proper pci API

> +posix-timers-tidy-up-clock-interfaces-and-consolidate-dispatch-logic.patch

umm, this adds extreme obsfucation.  Roland, please try to follow normal
Linux style, thanks.

