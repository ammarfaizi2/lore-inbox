Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUHIOgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUHIOgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUHIOfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:35:04 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:57625 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266611AbUHIOch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:32:37 -0400
Message-ID: <d577e56904080907324fe46002@mail.gmail.com>
Date: Mon, 9 Aug 2004 10:32:31 -0400
From: Patrick McFarland <diablod3@gmail.com>
To: Bob Deblier <bob.deblier@telenet.be>
Subject: Re: AES assembler optimizations
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1092059277.4332.8.camel@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1092059277.4332.8.camel@orion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 15:47:57 +0200, Bob Deblier <bob.deblier@telenet.be> wrote:
> Just picked up on KernelTrap that there were some problems with
> optimized AES code; if you wish, I can provide my own LGPL licensed (or
> I can relicense them for you under GPL), as included in the BeeCrypt
> Cryptography Library.

Well, it ended up being that the author that was complaining about
license violations allowed Linus to use his code, AND someone else
rewrote the stuff not to use the offending code. If you want to help
us out, make a kernel patch of your code.

> I have generic i586 code and SSE-optimized code available in GNU
> assembler format. Latest version is always available on SourceForge
> (http://sourceforge.net/cvs/?group_id=8924).
> 
> Please cc: me for responses, as I'm not a list subscriber.
> 
> Sincerely,
> 
> Bob Deblier
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
