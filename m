Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVDTIjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDTIjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDTIjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:39:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261309AbVDTIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:39:35 -0400
Date: Wed, 20 Apr 2005 09:39:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mlindner@syskonnect.de, rroesler@syskonnect.de,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/sk98lin/: possible cleanups
Message-ID: <20050420083928.GA29040@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, mlindner@syskonnect.de,
	rroesler@syskonnect.de, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050420021526.GB5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420021526.GB5489@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 04:15:26AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - remove unused code

Not sure it's worth doing much on this, as the driver is beeing
obsoleted by the skge driver.
