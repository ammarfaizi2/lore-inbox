Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUCSJ3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUCSJ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:29:41 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:47053 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262058AbUCSJ3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:29:40 -0500
Date: Fri, 19 Mar 2004 10:29:30 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319092930.GA17938@wohnheim.fh-wedel.de>
References: <20040318231006.GK11010@waste.org> <20040319003252.GB11450@wohnheim.fh-wedel.de> <20040319030942.GM11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040319030942.GM11010@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 March 2004 21:09:42 -0600, Matt Mackall wrote:
> 
> The code for new versions of zlib is significantly scarier last I
> checked and there's no particular advantage to it. But one of the
> primary motivations here is to get to the point where something like
> bunzip2 or even a new zlib is a drop-in replacement.

Zlib 1.2.1 is supposed to be much faster, but they intoduced new code
so the price appears to be size.  I'll look into it for the other zlib
in the kernel if noone finds the time before me.

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous
