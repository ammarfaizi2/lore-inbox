Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVAYHMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVAYHMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVAYHMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:12:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261845AbVAYHMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:12:01 -0500
Date: Tue, 25 Jan 2005 07:11:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050125071151.GA14755@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125060256.GB2061@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:02:56PM -0800, Greg KH wrote:
> > It would be a lot more productive to follow the normal rules, though.
> > That is posting them on lkml as properly split up patches, and with
> > proper descriptions of what they're doing.
> 
> As previously mentioned, these patches have had that, on the sensors
> mailing list.  Lots of review and comments went into them there, and the
> code was reworked quite a lot based on it.
> 
> Surely you don't want me to forward _every_ driver patch that I get to
> lkml first?  :)

If you add completely new subsystems please send them to lkml first.
