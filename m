Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUIWAqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUIWAqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUIWAqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:46:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:60844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266236AbUIWAqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:46:02 -0400
Date: Wed, 22 Sep 2004 17:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-Id: <20040922174939.7df18709.akpm@osdl.org>
In-Reply-To: <16722.7004.928367.771460@wombat.chubb.wattle.id.au>
References: <747804697@toto.iv>
	<16722.7004.928367.771460@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
> >>>>> "Jesse" == Jesse Barnes <jbarnes@engr.sgi.com> writes:
> 
> Jesse> On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> >> - This kernel doesn't work on ia64 (instant reboot).  But neither
> >> does 2.6.9-rc2, nor current Linus -bk.  Is it just me?
> 
> Jesse> I certainly hope so.  Current bk works on my 2p Altix, and iirc
> Jesse> 2.6.9-rc2 worked as well.  I'm trying 2.6.9-rc2-mm2 right now.
> Jesse> I haven't tried generic_defconfig yet either, maybe that's it?
> 
> It no longer works on ZX.  Don't know why.
> 

umm, to which "it" do you refer?  Three kernel versions are under
discussion here...
