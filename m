Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265702AbSKALC1>; Fri, 1 Nov 2002 06:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265703AbSKALC1>; Fri, 1 Nov 2002 06:02:27 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:24812 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S265702AbSKALCZ>; Fri, 1 Nov 2002 06:02:25 -0500
Message-Id: <200211011106.gA1B6EFF001384@pool-141-150-241-241.delv.east.verizon.net>
Date: Fri, 1 Nov 2002 06:06:10 -0500
From: Skip Ford <skip.ford@verizon.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK console] console updates.
References: <20021030215258.A10037@infradead.org> <Pine.LNX.4.33.0210311731420.2733-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210311731420.2733-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Thu, Oct 31, 2002 at 05:37:50PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [141.150.241.241] at Fri, 1 Nov 2002 05:08:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Okay. Here is the new console system. The patch is against 2.5.45.
> Please note only vgacon has been fixed to work with this new api.
> 
> http://phoenix.infradead.org/~jsimmons/console.diff.gz
> 
> Diff stats:
>  arch/i386/vmlinux.lds.s                     |  109

Your patch creates the above linker script.  It appears to be a copy
of vmlinux.lds.S from the same directory.

-- 
Skip
