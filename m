Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVAXVdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVAXVdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVAXVbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:31:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261623AbVAXUeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:34:05 -0500
Date: Mon, 24 Jan 2005 20:33:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124203353.GA5048@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124175449.GK3515@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 06:54:49PM +0100, Adrian Bunk wrote:
> It seems noone who reviewed the SuperIO patches noticed that there are 
> now two modules "scx200" in the kernel...

Did anyone review them?

