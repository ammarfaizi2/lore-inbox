Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUHVRTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUHVRTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268038AbUHVRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:19:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30434 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268036AbUHVRSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:18:42 -0400
Message-Id: <200408221702.i7MH26Bp004124@localhost.localdomain>
To: Vincent Hanquez <tab@snarc.org>
cc: Albert Cahalan <albert@users.sourceforge.net>, benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics 
In-Reply-To: Message from Vincent Hanquez <tab@snarc.org> 
   of "Sun, 22 Aug 2004 16:45:01 +0200." <20040822144501.GA10017@snarc.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 22 Aug 2004 13:02:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Hanquez <tab@snarc.org> said:
> On Sun, Aug 22, 2004 at 06:41:32AM -0400, Albert Cahalan wrote:
> > The "or" is much easier, because it follows the
> > standard 3-register pattern. With "mr", which way
> > does it go? That's one more thing to remember.
> > In fact I don't know, but the "or" is obvious.
> > 
> > The 0 is your hint that the "or" isn't a plain "or".
> 
> Sure, but this is about mmenonic. When I see 'or', my mind doesn't make
> any link with 'move register' but only with 'or'. I have to process
> another term of the line (the 0) to see that the program want to move a
> register.

I'd assume somebody familiar with the architecture reads this as a matter
of course. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
