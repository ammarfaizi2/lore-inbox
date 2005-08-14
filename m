Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVHNJDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVHNJDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHNJDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:03:38 -0400
Received: from ns1.suse.de ([195.135.220.2]:31639 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932329AbVHNJDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:03:38 -0400
Date: Sun, 14 Aug 2005 11:03:24 +0200
From: Olaf Hering <olh@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Henrik Brix Andersen <brix@gentoo.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050814090324.GA9871@suse.de>
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org> <20050813234322.GA30563@suse.de> <20050814030256.GA21147@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050814030256.GA21147@taniwha.stupidest.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 13, Chris Wedgwood wrote:

> On Sun, Aug 14, 2005 at 01:43:22AM +0200, Olaf Hering wrote:
> 
> > It is used for /class/misc/$name/dev
> 
> Ick.  I would almost suggest we change that were it not too late.  I
> think keeping the decription is useful and desirable.

Where is the description visible?
