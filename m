Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVAOTWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVAOTWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVAOTWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:22:02 -0500
Received: from verein.lst.de ([213.95.11.210]:14538 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262313AbVAOTVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:21:45 -0500
Date: Sat, 15 Jan 2005 20:21:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup virtual console <-> selection.c interface
Message-ID: <20050115192134.GA1834@lst.de>
References: <20041231143457.GA9165@lst.de> <Pine.LNX.4.61.0501150431360.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501150431360.6118@scrub.home>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 04:36:55AM +0100, Roman Zippel wrote:
> I should really sent out my own patches faster. :)
> I have three patches which take this a bit further and removes these 
> macros completely and does some other small cleanups. It saves a bit more 
> than 3KB.

I was planning to do that aswell and have a few patches ontop already.
But obviously I don't care which set gets in as long as the mess gets
sorted out.
