Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTHOV7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHOV7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:59:04 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:11187 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S269900AbTHOV7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:59:03 -0400
Date: Fri, 15 Aug 2003 23:59:00 +0200
From: Kurt Roeckx <Q@ping.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Subject: Re: Problem with framebuffer in 2.6.0-test3
Message-ID: <20030815215900.GA172@ping.be>
References: <20030815142008.GA22123@ping.be> <20030815141846.083f3d2d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815141846.083f3d2d.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:18:46PM -0700, Andrew Morton wrote:
> Kurt Roeckx <Q@ping.be> wrote:
> >
> > If I compile with framebuffer I get weird results during boot.
> 
> Please test
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/broken-out/fbdev.patch
> 
> and send a report to linux-kernel and James Simmons <jsimmons@infradead.org>

It behaves just the same as plain 2.6.0-test3.


Kurt

