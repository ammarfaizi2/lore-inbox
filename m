Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbTAFWBT>; Mon, 6 Jan 2003 17:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAFWBS>; Mon, 6 Jan 2003 17:01:18 -0500
Received: from chunk.voxel.net ([207.99.115.133]:32394 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S267232AbTAFWBR>;
	Mon, 6 Jan 2003 17:01:17 -0500
Date: Mon, 6 Jan 2003 17:09:56 -0500
From: Andres Salomon <dilinger@voxel.net>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.54 atyfb_base.c compile fix
Message-ID: <20030106220956.GA32140@chunk.voxel.net>
References: <pan.2003.01.02.06.30.55.638527@voxel.net> <Pine.LNX.4.44.0301062149550.31831-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301062149550.31831-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool.  Now if only atyfb didn't completely mess up my console in 2.4 and
2.5, on my Dell Inspiron 3800 (Rage Mobility P/M, AGP 2x)..

I have too many other projects I'm working on right now to dedicate a
lot of time trying to fix it, but if you had suggestions for what to
try, I'd appreciate it.

Simply loading the atyfb module, without any args, causes the screen to
go blank.  I can see the cursor blinking, but I can't see any text
output.

On Mon, Jan 06, 2003 at 09:50:04PM +0000, James Simmons wrote:
> From: James Simmons <jsimmons@infradead.org>
> To: Andres Salomon <dilinger@voxel.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.5.54 atyfb_base.c compile fix
> 
> 
> Applied.

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson
