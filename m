Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSKNRZE>; Thu, 14 Nov 2002 12:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSKNRZE>; Thu, 14 Nov 2002 12:25:04 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:6607 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265135AbSKNRZD>; Thu, 14 Nov 2002 12:25:03 -0500
Date: Thu, 14 Nov 2002 10:31:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc1-ac2
Message-ID: <20021114173152.GA605@opus.bloom.county>
References: <200211141622.gAEGMhX17361@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211141622.gAEGMhX17361@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 11:22:43AM -0500, Alan Cox wrote:
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out, - indicates stuff not relevant to the main tree]
> 
> Linux 2.4.20-rc1-ac2
> o	Ptrace NT flag fix				(Andrea Arcangeli)
> o	lcall NT clear fixes				(Petr Vandrovec)

Is the patch from Andrea needed in addition to Petr's patch?  If I
followed the thread right it looks like Andrea later said that it wasn't
needed (and I've locally tested both test cases with just Petr's patch
with nothing bad seeming to happen).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
