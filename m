Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVAXMgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVAXMgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVAXMgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:36:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55939 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261287AbVAXMgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:36:14 -0500
Date: Mon, 24 Jan 2005 12:34:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fix SuperIO compilation
Message-ID: <20050124123448.GA29631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124122541.GG3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124122541.GG3515@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:25:41PM +0100, Adrian Bunk wrote:
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.11-rc1-mm2:
> >...
> >  bk-i2c.patch
> >...
> >  Latest versions of various bk trees
> >...
> 
> This causes the following compile error:

Where's that code coming from anyone?  Greg seems to be adding tons of not fully
reviewed stuff lately..

