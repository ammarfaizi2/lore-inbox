Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVFANkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFANkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFANkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:40:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:34450 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261203AbVFANkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:40:05 -0400
Date: Wed, 1 Jun 2005 15:39:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: coywolf@lovecn.org, cotte@freenet.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Message-ID: <20050601133938.GB29116@wohnheim.fh-wedel.de>
References: <428216DF.8070205@de.ibm.com> <2cd57c9005060103122b2bae36@mail.gmail.com> <200506011406.04191.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506011406.04191.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 June 2005 14:06:03 +0200, Arnd Bergmann wrote:
> On Middeweken 01 Juni 2005 12:12, Coywolf Qi Hunt wrote:
> > > 
> > > As I'd like to aim for integration into -mm and vanilla later on,
> > > I'd like to encourage everyone to give it a read and provide
> > > feedback. All patches apply against git-head as of today.
> > 
> > I feel the name "execute in place" misleading. This is not the real
> > XIP, IMHO. Invent another term or be tolerant?
> 
> If this is not real execute in place, then what is? The term seems to
> describe the patch rather well and we don't have this ability for Linux
> applications anywhere else, at least not in official kernels.

We can execute the kernel in place, thanks to Nicolas Pitre.  For
userspace I have seen to preparation patches, but nothing serious.

Jörn

-- 
I've never met a human being who would want to read 17,000 pages of
documentation, and if there was, I'd kill him to get him out of the
gene pool.
-- Joseph Costello
