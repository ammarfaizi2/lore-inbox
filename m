Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWFFWLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFFWLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFFWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:11:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55241 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751207AbWFFWLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:11:21 -0400
Message-Id: <200606062210.k56M9u7f008189@laptop11.inf.utfsm.cl>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       "Kalin KOZHUHAROV" <kalin@thinrope.net>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
Subject: Re: Linux kernel development 
In-Reply-To: Message from "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> 
   of "Tue, 06 Jun 2006 21:22:50 +0200." <4d8e3fd30606061222l3567ed46td1c9c772ab57c056@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 06 Jun 2006 18:09:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 06 Jun 2006 18:10:35 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 6/3/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> [...]
> > Perhaps do an asccidoc format, to be able to create HTML?

> Just pushed out a first html version done via asciidoc.

Awesome.

But don't push out generated files, better add a Makefile to (re)generate
them.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
