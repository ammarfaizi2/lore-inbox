Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUAHBNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAHBNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:13:48 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:53258 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263244AbUAHBNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:13:47 -0500
Date: Thu, 8 Jan 2004 01:13:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Fix softcursor in 2.6.X
In-Reply-To: <20040103153310.GA617@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0401072045500.31020-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> Softcursor was broken for half of 2.5 series. This fixes it by first
> hiding cursor _then_ hiding softcursor. Very simple mistake... Please
> apply,

Just tested with vgacon, fbcon with software cursor and hardware cursor. 
It worked!!!!! 

Thank you, Thank you.

