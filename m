Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTFWXRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTFWXQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:16:35 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:57613 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265573AbTFWXNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:13:24 -0400
Date: Tue, 24 Jun 2003 01:27:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] loop.c
Message-ID: <20030624012729.A1133@pclin040.win.tue.nl>
References: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl> <20030623161430.GA23657@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030623161430.GA23657@stingr.net>; from i@stingr.net on Mon, Jun 23, 2003 at 08:14:30PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 08:14:30PM +0400, Paul P Komkoff Jr wrote:

> Replying to Andries.Brouwer@cwi.nl:
> > Below a patch for loop.[ch]. It can be applied.
> 
> Please, can anybody review the possibility of making offset LARGEFILE-capable?

These patches make lo_offset a loff_t.

