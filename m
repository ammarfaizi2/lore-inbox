Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269549AbUIROnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269549AbUIROnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269533AbUIROnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:43:16 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:46985 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269549AbUIROnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:43:09 -0400
Message-ID: <1a56ea3904091807437ce86616@mail.gmail.com>
Date: Sat, 18 Sep 2004 15:43:08 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: FASTCALL fixing?
In-Reply-To: <200409172223.i8HMNgNu004437@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409172223.i8HMNgNu004437@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 00:23:42 +0200 (MEST), Mikael Pettersson
<mikpe@csd.uu.se> wrote:
> On Fri, 17 Sep 2004 18:38:46 +0100, DaMouse <damouse@gmail.com> wrote:
> >       I get errors about the fastcall and type conflicts in 2.4.27
> >(yeah its old.. i know :) ) I was wondering what the politically
> >correct way of fixing these are? adding fastcall type to
> >kernel/sched.c or removing FASTCALL() around it in sched.h?
> 
> gcc-3.4? Known issue. Fixed in 2.4.28-pre ages ago,
> as the LKML archives should have told you.
> 

Yeah, sorry i didn't think to look in 2.4.28-pre, thanks :)

-DaMouse


-- 
I know I broke SOMETHING but its there fault for not fixing it before me
