Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTA1L3k>; Tue, 28 Jan 2003 06:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTA1L3k>; Tue, 28 Jan 2003 06:29:40 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:5392 "EHLO hexagon.stack.nl")
	by vger.kernel.org with ESMTP id <S265169AbTA1L3k>;
	Tue, 28 Jan 2003 06:29:40 -0500
Date: Tue, 28 Jan 2003 12:38:57 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <20030128110541.GA5035@riesen-pc.gr05.synopsys.com>
Message-ID: <20030128123029.O28475-100000@snail.stack.nl>
References: <398E93A81CC5D311901600A0C9F29289469376@cubuss2>
 <20030128110541.GA5035@riesen-pc.gr05.synopsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Alex Riesen wrote:

> > But this is also a question of attitude to me. Even if
> > only a fake, I want Linux to be a *graphical* OS. *g*
>
> put svgalib in kernel and export it's interface?

Fbcon, Kernel Graphics Interface (http://kgi-wip.sourceforge.net, no we
don't use ioctls or kernel space for accelleration anymore). Enough choice
for your "graphical OS" ;-)

Jos
