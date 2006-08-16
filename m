Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWHPTT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWHPTT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWHPTT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:19:29 -0400
Received: from mail.linicks.net ([217.204.244.146]:20485 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750922AbWHPTT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:19:28 -0400
From: Nick Warne <nick@linicks.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: PATCH: Fix crash case
Date: Wed, 16 Aug 2006 20:19:12 +0100
User-Agent: KMail/1.9.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1155746131.24077.363.camel@localhost.localdomain> <7c3341450608161210ua4d0d4esc54f98c3ada69f3d@mail.gmail.com> <Pine.LNX.4.58.0608161214380.30053@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0608161214380.30053@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162019.12678.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 20:15, Randy.Dunlap wrote:

> > Sorry for being a noob here - I read LKML to try to learn.
> >
> > What is meant by 'If we are going to BUG()...  cover the case
> > of the BUG being compiled out'.
> >
> > What would make BUG(); not being compiled?
>
> It's a config option is EMBEDDED=y:
>

Ah!  That option.  OK, thanks.

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
