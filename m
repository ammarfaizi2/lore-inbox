Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFORAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFORAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:00:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:28176 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262409AbTFOQ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:57:20 -0400
Date: Sun, 15 Jun 2003 18:11:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mochel@osdl.org, david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: GFDL in the kernel tree
Message-ID: <20030615181107.B19242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, mochel@osdl.org,
	david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <20030615140758.A9390@infradead.org> <Pine.LNX.4.44.0306150942280.8088-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306150942280.8088-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jun 15, 2003 at 09:48:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 09:48:45AM -0700, Linus Torvalds wrote:
> 
> On Sun, 15 Jun 2003, Christoph Hellwig wrote:
> > 
> > Folks, could we please only use GPL-compatible licenses in the kernel
> > tree?
> 
> I'd agree. The GFDL is a disaster anyway.  You can't even fix bugs in the
> documentation without having to change the title etc. There are much
> better licenses around.
> 
> I'd say we just remove the files.

Okay, I'll wait a day or two for the copyright holders to comment and
maybe change the license and then submit a patch.

