Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSGYW45>; Thu, 25 Jul 2002 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSGYW45>; Thu, 25 Jul 2002 18:56:57 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15428 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316629AbSGYW45>; Thu, 25 Jul 2002 18:56:57 -0400
Date: Fri, 26 Jul 2002 01:01:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Cort Dougan <cort@fsmlabs.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725230100.GX1180@dualathlon.random>
References: <20020725205910.GR1180@dualathlon.random> <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 07:41:39PM -0300, Rik van Riel wrote:
> On Thu, 25 Jul 2002, Andrea Arcangeli wrote:
> 
> > valuable for what? you need the system.map or the .o disassembly of the
> > module anyways to take advantage of such symbol. I don't find it useful.
> 
> If you're willing to teach all our users how to use ksymoops ... ;)

I don't even need to ask them the system.map if I compiled the kernel
myself.

Andrea
