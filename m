Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSA3EOk>; Tue, 29 Jan 2002 23:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288402AbSA3EOU>; Tue, 29 Jan 2002 23:14:20 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33482 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288395AbSA3EOI>;
	Tue, 29 Jan 2002 23:14:08 -0500
Date: Tue, 29 Jan 2002 23:14:03 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129231403.A22449@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0201291938530.26901-100000@verdande.oobleck.net> <Pine.LNX.4.33.0201291851270.1766-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201291851270.1766-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 06:54:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 06:54:04PM -0800, Linus Torvalds wrote:
> Basically, I'd really like documentation to go with the thing it
> documents. This is something where the docbook stuff helped noticeably.

Well...  kinda sorta.

We -used- to really have documentation with the thing it documents, like
drivers/foo/README.  In-lined source comments are one piece of the
puzzle yes, but the -bulk- of the docs are not anywhere near the thing
it documents.

I actually don't like stuffing documents in Documentation/DocBook
proper...  I've put docs for two drivers in there, but if the trend
continues a new dir structure will need to evolve.

Either we'll want Documentation/DocBook/<category>, or move the docbook
docs into the standard Documentation/* hierarchy......... or we'll start
moving docs back outside Documentation/*

	Jeff, on a semi-tangent



