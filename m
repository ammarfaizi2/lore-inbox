Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWGLRco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGLRco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWGLRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:32:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932142AbWGLRco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:32:44 -0400
Subject: Re: [PATCH 4/5] PCI-Express AER implemetation: AER core and
	aerdriver
From: Arjan van de Ven <arjan@infradead.org>
To: Johnny Lever <johnny.lever@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c770ab230607121021k550c3d2epf6acefa8fed491a1@mail.gmail.com>
References: <c770ab230607121021k550c3d2epf6acefa8fed491a1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 19:32:42 +0200
Message-Id: <1152725562.3217.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 13:21 -0400, Johnny Lever wrote:
> >With Arjan's comments, I changed EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.
> Sorry for flooding your emailbox again. :)
> 
> I think we should have "moron-proof" review system on LKML. Simplest
> way to get started is to ignore the EXPORT_SYMBOL_GPL "missionaries"
> trying to 'convert' code without giving proper thought to its
> implications or without ascertaining the correctness of the
> conversion.

I don't know where you get the "convert" idea from; this is new code and
new, linux specific API/functionality.

Some companies and people contribute a lot to the Linux kernel, all
under the GPL. In my opinion it is entirely fair that those companies
can expect that their efforts, which are new and Linux specific
functionality/APIs, will be used in compliance with the license and in a
level playing field. With "Level playing field" I mean that their
competitors ought to play by the same rules, eg comply with the letter
and spirit of the GPL. These companies make a sacrifice by giving their
code up under the GPL rather than charging for it proprietary, and they
do so gladly (and for their internal reasons). Demanding that these
companies then also allow that same code to be used by other companies
who do not give anything back to Linux... is just really bad for Linux
both in the short and the long term.

> Dimwits.

good thing you're using a fake gmail account instead of your own name,
it means it's just a very obvious troll attempt....

