Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSJ3X3d>; Wed, 30 Oct 2002 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265067AbSJ3X3d>; Wed, 30 Oct 2002 18:29:33 -0500
Received: from dp.samba.org ([66.70.73.150]:18145 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265066AbSJ3X3c>;
	Wed, 30 Oct 2002 18:29:32 -0500
Date: Thu, 31 Oct 2002 10:31:07 +1100
From: Anton Blanchard <anton@samba.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] use asm-generic/topology.h
Message-ID: <20021030233107.GB4820@krispykreme>
References: <3DC056C2.4070609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC056C2.4070609@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt,

> use_generic_topology.patch
> 
> This patch changes ppc64 & alpha to use the generic topology.h for the 
> non-NUMA case rather than redefining the same macros.  It is much easier 
> to maintain one set of generic non-NUMA macros than several.

Looks good from the ppc64 perspective.

Anton
