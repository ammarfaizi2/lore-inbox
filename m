Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbULON25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbULON25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 08:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbULON24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 08:28:56 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7625 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262352AbULON2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 08:28:51 -0500
Message-Id: <200412151328.iBFDSQoH011241@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: file as a directory 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Tue, 14 Dec 2004 21:10:05 -0800." <41BFC72D.2070800@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 15 Dec 2004 10:28:26 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Horst von Brand wrote:
> >Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:

> >[...]

> >>Perhaps a better way to think about this is that instead of talking
> >>about directories and files, we just talk about objects.

> >Then you have a collection of interrelated objects, i.e., a database.
> >Operating systems that work on databases (no filesystem) have been done,
> >and are a nice idea... but are far, far away from Unix.

> A journey of a thousand leagues begins with a single step.

Right.  But you need to know where you are going, and why.

> Actually, databases are the wrong solution because they are relational, 

Says who?

> and what is needed is a semi-structured query language that is upwardly 
> compatible with Unix hierarchical semantics, ala 
> www.namesys.com/future_vision.html
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
