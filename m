Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUDYEKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUDYEKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 00:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDYEKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 00:10:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9925 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262897AbUDYEKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 00:10:02 -0400
Message-Id: <200404250401.i3P41ONF004481@pincoya.inf.utfsm.cl>
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jason Cox <steel300@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices 
In-Reply-To: Your message of "Sun, 25 Apr 2004 04:15:57 +0100."
             <Pine.LNX.4.44.0404250414330.15965-100000@phoenix.infradead.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 25 Apr 2004 00:01:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> said:
> > On Thu, Apr 22, 2004 at 02:24:06AM +0000, Jason Cox wrote:
> > > > When the kernel supports multi-desktop systems we will have to deal
> > > > with the serial and VT issue. Most likely the serial tty drivers will
> > > > be given a different major number. 
> > > 
> > > Why isn't this done now?
> > 
> > It's a API change and requires a flag day "everyone update their
> > filesystem."  Especially in a stable kernel series.
> 
> By the time 2.7.X comes around everyone should be using udev. That should 
> settle any problems. 

Dream on. When 2.8.x/3.0.x finally starts shipping, users will scream their
heads off about this "new udev thingy" they are now supposed to use
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
