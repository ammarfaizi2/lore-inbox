Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSJ3ToX>; Wed, 30 Oct 2002 14:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSJ3ToX>; Wed, 30 Oct 2002 14:44:23 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:12712 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264877AbSJ3ToU>; Wed, 30 Oct 2002 14:44:20 -0500
Date: Wed, 30 Oct 2002 12:50:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <20021030195034.GA27472@opus.bloom.county>
References: <20021030171149.GA15007@suse.de> <1036006381.5297.108.camel@irongate.swansea.linux.org.uk> <765420000.1036005439@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765420000.1036005439@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:17:20AM -0800, Martin J. Bligh wrote:
> > Can you also mention not using gcc 3.0.x (stack pointer handling bug)
> 
> Any chance of putting this sort of thing as #error detection
> in the compile so it auto-breaks? I seem to recall that's done
> for some versions of GCC already ...

And what arch is that for?  Adding a nice facility for per-arch (and
maybe global) compiler / binutils testing would be nice, if we're going
to go down that road..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
