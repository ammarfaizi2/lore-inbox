Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVBREPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVBREPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 23:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBREPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 23:15:15 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63442 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261232AbVBREPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 23:15:10 -0500
Message-Id: <200502180232.j1I2W7nJ007744@laptop11.inf.utfsm.cl>
To: Clemens Schwaighofer <cs@tequila.co.jp>
cc: "Theodore Ts'o" <tytso@mit.edu>, Olivier Galibert <galibert@pobox.com>,
       kernel@crazytrain.com, linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed 
In-Reply-To: Message from Clemens Schwaighofer <cs@tequila.co.jp> 
   of "Fri, 18 Feb 2005 09:29:47 +0900." <421536FB.5000606@tequila.co.jp> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 17)
Date: Thu, 17 Feb 2005 23:31:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> said:
> On 02/17/2005 01:57 PM, Theodore Ts'o wrote:
> > Compare the number of developers, the number of overlapping
> > simultaneous development trees, and the number of patches that touch
> > overlapping files, and you'll begin to start to appreciate the
> > difference between a system that can work for Linux, and a system that
> > can working for simpler projects.

> apache might be simpler, but I doubt that for gcc. But well lets see
> what the gcc guys will decide.

gcc has very much less developers than the kernel. It has worked for years
around CVS' shortcommings, plus being a core GNU package, it is quite
unlikely to /ever/ go for a non-oss SCM. Plus the bureaucracy (have to have
a paper signing over ownership to the FSF for any changes) make a fully
Linux-style development unlikely (and thus BK (which was designed as SCM
for the kernel) not really useful).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
