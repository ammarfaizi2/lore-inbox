Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUHQWZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUHQWZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHQWZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:25:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:37546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268474AbUHQWZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:25:34 -0400
Date: Tue, 17 Aug 2004 15:29:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
Message-Id: <20040817152905.3d042522.akpm@osdl.org>
In-Reply-To: <20040817215940.GA13576@janus>
References: <20040817103852.GA18758@elf.ucw.cz>
	<20040817215940.GA13576@janus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen <frankvm@xs4all.nl> wrote:
>
> On Tue, Aug 17, 2004 at 12:38:52PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > -	} while (0)
> > +	} while(0)
> 
> "while" is not a function so I'd keep the space.

My stealth error corrector already did that ;)
