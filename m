Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJ1OzU>; Mon, 28 Oct 2002 09:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJ1OzU>; Mon, 28 Oct 2002 09:55:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57730 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261287AbSJ1OzT>; Mon, 28 Oct 2002 09:55:19 -0500
Date: Mon, 28 Oct 2002 10:03:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andi Kleen <ak@suse.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler (lmben ch data)
In-Reply-To: <20021028155123.A13576@wotan.suse.de>
Message-ID: <Pine.LNX.3.95.1021028100112.14148A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andi Kleen wrote:

> On Mon, Oct 28, 2002 at 06:47:27AM -0800, Nakajima, Jun wrote:
> > I don't think people need to use PGO for day-to-day development or
> > debugging. Rather, it would be used only for systems deployed for actual
> > use. For example, various kernel binaries optimized for particular use, such
> > as database, web server, file server, embedded systems, etc, can be
> > distributed as RPM (with profile feedback data). 
> 
> But unless these kernels are 100% bug free it still leaves the mainteance
> issues open.

Hmmm.... Where can I get a 100% bug-free kernel?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


