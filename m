Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286496AbRLUAUy>; Thu, 20 Dec 2001 19:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286497AbRLUAUo>; Thu, 20 Dec 2001 19:20:44 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:46990
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S286496AbRLUAUc>; Thu, 20 Dec 2001 19:20:32 -0500
Date: Thu, 20 Dec 2001 17:20:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011221002030.GT763@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <15394.29882.361540.200600@irving.iisd.sra.com> <20011220185226.A25080@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220185226.A25080@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 06:52:26PM -0500, Eric S. Raymond wrote:
> David Garfield <garfield@irving.iisd.sra.com>:
> > Another option: maybe the choice of KB vs KiB vs KKB should be a
> > configuration choice.
> 
> You *must* be joking.
> 

Hopefully.  Here's a serious one tho.  Why don't we say at the bottom:
1 kB (or KB or KiB or ...) is 2^10 bytes.  Like we do for code that can
be compiled as a module...  As long as we're consistant in the suffix,
and we define it, it doesn't matter what it is.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
