Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbUJ1Vyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbUJ1Vyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUJ1Vvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:51:36 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:20618 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262920AbUJ1VtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:49:10 -0400
Date: Thu, 28 Oct 2004 14:43:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces
Message-ID: <20041028214347.GC2269@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282034.21922.blaisorblade_spam@yahoo.it> <20041028192824.GC851@taniwha.stupidest.org> <200410282302.48311.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282302.48311.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 11:02:48PM +0200, Blaisorblade wrote:

> If Jeff says "OK", then someone can submit a separate patch removing
> all the final comments.

he did

> And never mix such unrelated changes in a patch.

idealistically i agree, but doing trivial / obvious cleanups inside
other patches is fine if you ask me

it's not like we are mixing semantically different changes

