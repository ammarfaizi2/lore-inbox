Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280859AbRKBWoN>; Fri, 2 Nov 2001 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280863AbRKBWoF>; Fri, 2 Nov 2001 17:44:05 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7081 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S280860AbRKBWny>; Fri, 2 Nov 2001 17:43:54 -0500
Date: Fri, 2 Nov 2001 15:43:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ethan <e-d0uble@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC kernel ide modules failing [PATCH?]
Message-ID: <20011102154339.C29828@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BE30EDC.4030301@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE30EDC.4030301@stinkfoot.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 04:23:40PM -0500, Ethan wrote:

> ..answering myself here..  as I found that this problem occurs using a bunch 
> of different trees (bk, ben, stock, etc..)
> I have fixed this issue (albeit in possibly a completely incorrect and bad 
> way)I'm certainly no programmer, and definately not a kernel hacker.
> I was wondering if this is the correct way to handle this:

For now it's actually preferable to throw it in ppc_ksyms.c.  I'll do so
shortly.  Thanks for looking into this.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
