Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbTCMVhC>; Thu, 13 Mar 2003 16:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbTCMVhC>; Thu, 13 Mar 2003 16:37:02 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58790 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262575AbTCMVhB>;
	Thu, 13 Mar 2003 16:37:01 -0500
Message-Id: <200303132045.h2DKjAsK005736@eeyore.valparaiso.cl>
To: Larry McVoy <lm@bitmover.com>
cc: Nicolas Pitre <nico@cam.org>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror) 
In-Reply-To: Your message of "Wed, 12 Mar 2003 12:58:59 PST."
             <20030312205859.GG7275@work.bitmover.com> 
Date: Thu, 13 Mar 2003 16:45:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> said:

[...]

> So here's a question.  Suppose we have a series of deltas being clumped
> together in a file.  All made by different people.  Whose name wins?
> My gut is to sort them, run them through uniq -c, and take the top one.
> The other idea is to count up lines inserted/deleted over each delta
> and take the user who has done the most work.

Say Several and add the list to the comment (after sort | uniq)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
