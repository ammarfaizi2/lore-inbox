Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVAZLCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVAZLCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 06:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVAZLCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 06:02:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262274AbVAZLCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 06:02:07 -0500
Date: Wed, 26 Jan 2005 11:02:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation updates
Message-ID: <20050126110206.GA8306@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050126105621.GW3069@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126105621.GW3069@admingilde.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:56:21AM +0100, Martin Waitz wrote:
> hoi :)
> 
> I have created some updates to the Linux documentation.
> 
> This includes two important fixes that allow to generate DocBook
> documenation from kernel-doc comments again and some low-priority
> updates to the kernel-doc comments itself.
> 
> All patches are available in my BK repository, it only contains
> documentation updates, no code changes.
> (The fixes have been reported here before but have not been merged yet.)

Cool!  Btw, anybody's got an idea how to speedup generating the documentation
from the DocBook templates?  There surely must be some faster parsers, it's
currently taking up the majority of the time used to build kernel-source
packages on Debian.

