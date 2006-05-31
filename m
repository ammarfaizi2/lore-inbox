Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWEaVBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWEaVBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWEaVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:01:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:42219 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964986AbWEaVBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:01:07 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: linux-2.6 x86_64 kgdb issue
Date: Wed, 31 May 2006 23:01:56 +0200
User-Agent: KMail/1.9.1
Cc: piet@bluelane.com, "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <446E0B4B.9070003@ru.mvista.com> <200605310913.54758.ak@suse.de> <20060531150343.GZ31210@smtp.west.cox.net>
In-Reply-To: <20060531150343.GZ31210@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605312301.56452.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 17:03, Tom Rini wrote:
> On Wed, May 31, 2006 at 09:13:53AM +0200, Andi Kleen wrote:
>
> [snip]
>
> > Yes because you if modular works you don't need to build it in.
> >
> > Modular was working at some point on x86-64 for kdb and the original 2.6
> > version of kgdb was nearly there too.
>
> FWIW, the only change the current version of kgdb makes that would
> prevent it from being totally modular is the debugger_active check in
> 

Can you post the patch and a description? 

-Andi
