Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWIYNa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWIYNa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWIYNa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:30:57 -0400
Received: from 1wt.eu ([62.212.114.60]:18963 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751200AbWIYNa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:30:56 -0400
Date: Mon, 25 Sep 2006 15:07:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: An Ode to GPLv2 (was Re: GPLv3 Position Statement)
Message-ID: <20060925130711.GC1517@1wt.eu>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609241917520.3952@g5.osdl.org> <20060925044010.GN541@1wt.eu> <1159185611.3085.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159185611.3085.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:00:05PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-09-25 at 06:40 +0200, Willy Tarreau wrote:
> > do a few months back. After all the fuss about binary-only modules
> > incompatibility with GPLv2, I wanted to change the license of haproxy
> > to explicitly permit external binary-only code to be linked with it. 
> 
> LGPL is then a logical and commonly accepted choice for a license

Not exactly, because I don't want people to include interesting parts
of my code into their binary-only programs. I just want to allow
people to link binary-only modules with my program. However, programs
that are already GPLv2 are welcome to steal part of my code.

Regards,
Willy

