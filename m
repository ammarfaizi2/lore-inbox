Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293058AbSBWAfz>; Fri, 22 Feb 2002 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSBWAfp>; Fri, 22 Feb 2002 19:35:45 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:53387
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S293058AbSBWAfh>; Fri, 22 Feb 2002 19:35:37 -0500
Date: Fri, 22 Feb 2002 17:35:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@caldera.de>, lm@bitmover.com, hpa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 bitkeeper repository
Message-ID: <20020223003513.GM719@opus.bloom.county>
In-Reply-To: <20020222193723.GL719@opus.bloom.county> <Pine.LNX.4.33L.0202221648320.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202221648320.7820-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 04:49:07PM -0300, Rik van Riel wrote:
> On Fri, 22 Feb 2002, Tom Rini wrote:
> 
> > If you have a pristine tree, adding incremental diffs is:
> > bk import -tpatch ../patch-2.4.X-preY-preZ . && bk tag v2.4.X-preZ
> > Which is what I do for the PPC's kernel.org-only tree(s).
> 
> You forgot about setting the proper BK_USER, BK_HOST and
> 'bk comment' commands ;)

heh.  Those are rather new things, aren't they? :)  Anyhow, the goal for
these tree(s) is to keep the PPC children trees up to date.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
