Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbSKSUjl>; Tue, 19 Nov 2002 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbSKSUjl>; Tue, 19 Nov 2002 15:39:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18816 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267199AbSKSUjk>;
	Tue, 19 Nov 2002 15:39:40 -0500
Date: Tue, 19 Nov 2002 12:46:40 -0800
From: Bob Miller <rem@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trivial@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH 2.5.48] Remove unused function from radeon_mem.c
Message-ID: <20021119204640.GA4884@doc.pdx.osdl.net>
References: <20021119185015.GG1986@doc.pdx.osdl.net> <1037735233.12086.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037735233.12086.30.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 07:47:13PM +0000, Alan Cox wrote:
> Can you leave this one. Its just going to make resynching with the
> XFree86 4.3 DRM harder. The DRM in the kernel is about to become
> obsolete anyway
Cool.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
