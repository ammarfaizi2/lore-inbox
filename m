Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTBCXNa>; Mon, 3 Feb 2003 18:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTBCXNa>; Mon, 3 Feb 2003 18:13:30 -0500
Received: from ns.suse.de ([213.95.15.193]:55053 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265457AbTBCXNa>;
	Mon, 3 Feb 2003 18:13:30 -0500
Date: Tue, 4 Feb 2003 00:22:20 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
Message-ID: <20030203232220.GA15469@wotan.suse.de>
References: <336780000.1044313506@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336780000.1044313506@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:05:06PM -0800, Martin J. Bligh wrote:
> The results below leaves me distinctly unconvinced by the supposed 
> merits of modern gcc's. Not really better or worse, within experimental
> error. But much slower to compile things with.

Curious - could you compare it with a gcc 3.3 snapshot too?

It should be even slower at compiling, but generate better code.

-Andi
