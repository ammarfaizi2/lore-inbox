Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRHGRBz>; Tue, 7 Aug 2001 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269049AbRHGRBo>; Tue, 7 Aug 2001 13:01:44 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:24070 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S269041AbRHGRBh>; Tue, 7 Aug 2001 13:01:37 -0400
Message-Id: <200108031443.f73EhQLX017842@pincoya.inf.utfsm.cl>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread 
In-Reply-To: Your message of "Fri, 03 Aug 2001 15:09:06 +0200."
             <01080315090600.01827@starship> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 03 Aug 2001 10:43:26 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> said:
> On Friday 03 August 2001 05:13, Alexander Viro wrote:

[...]

> > You forgot ".. at any given moment". IOW, operation you propose is
> > inherently racy. You want to do that - you do that in userland.

> Are you saying that there may not be a ".." some of the time?  Or just 
> that it may spontaneously be relinked?  If it does spontaneously change 
> it doesn't matter, you have still made sure there is access by at least 
> one path.

Think "mv thisdir somewhereelse"
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
