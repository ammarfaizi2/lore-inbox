Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933690AbWKWNUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933690AbWKWNUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933688AbWKWNUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:20:11 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:25826 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S933690AbWKWNUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:20:09 -0500
Subject: Re: BUG: 2.6.19-rc6 net/irda/irlmp.c
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Ian Molton <spyro@f2s.com>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
References: <45657BD4.5040604@f2s.com>
	 <9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 14:15:45 +0100
Message-Id: <1164287745.5968.206.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 14:13 +0100, Jesper Juhl wrote:

> Linus: I think that commit should either be reverted or fixed in a
> different way before 2.6.19.

Andrew already said he'd push the required patches to Linus:

  http://lkml.org/lkml/2006/11/22/283



