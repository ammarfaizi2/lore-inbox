Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTA1SOq>; Tue, 28 Jan 2003 13:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTA1SOq>; Tue, 28 Jan 2003 13:14:46 -0500
Received: from vitelus.com ([64.81.243.207]:1541 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S267649AbTA1SOq>;
	Tue, 28 Jan 2003 13:14:46 -0500
Date: Tue, 28 Jan 2003 10:21:33 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
Cc: "'Stefan Reinauer'" <stepan@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: AW: Bootscreen
Message-ID: <20030128182133.GN18700@vitelus.com>
References: <398E93A81CC5D311901600A0C9F2928946938B@cubuss2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946938B@cubuss2>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 03:53:58PM +0100, Raphael Schmid wrote:
> > In vesafb this is different. The video mode is set before 32bit mode is
> > entered, then the 32bit part of the kernel just assumes it can paint to
> > some memory found attached to the graphics device.
> > Still, for painting a bootsplash screen using fbcon, this does not
> > matter as all you need is the framebuffer memory.
> Well, I believe we had quite some "threads" developing in this thread now,

Yes, can you please stop breaking threading?
