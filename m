Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVHaOjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVHaOjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 10:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHaOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 10:39:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35513 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932345AbVHaOjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 10:39:19 -0400
Date: Wed, 31 Aug 2005 07:39:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 16/16] Add hardware breakpoint support for i386
Message-ID: <20050831143918.GG3966@smtp.west.cox.net>
References: <resend.15.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.16.2982005.trini@kernel.crashing.org> <p73wtm4fndw.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wtm4fndw.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 11:23:39PM +0200, Andi Kleen wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
> 
> > This adds hardware breakpoint support for i386.  This is not as well tested as
> > software breakpoints, but in some minimal testing appears to be functional.
> 
> This really would need so coordination with user space using 
> them. Otherwise it'll be quite unreliable because any user program
> can break it.

Probably easiest to just drop this for now then, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
