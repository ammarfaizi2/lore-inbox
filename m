Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTATWKu>; Mon, 20 Jan 2003 17:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTATWKu>; Mon, 20 Jan 2003 17:10:50 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:7787 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267206AbTATWKt>; Mon, 20 Jan 2003 17:10:49 -0500
Date: Tue, 21 Jan 2003 00:19:43 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: John Bradford <john@grabjohn.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, peter900000@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel C++ compiler?
Message-ID: <20030120221943.GV1258@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
	peter900000@hotmail.com, linux-kernel@vger.kernel.org
References: <20030120165417.GB27972@gtf.org> <200301201711.h0KHBEYR005837@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301201711.h0KHBEYR005837@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 05:11:14PM +0000, you [John Bradford] wrote:
> > > > Does Intels C++ compiler for Linux works fine for compiling the Linux
> > > > kernel? It is not 100% compatible, as far as I know.
> > > 
> > > I doubt it - Linux makes extensive use of GCC compiler extensions.
> > 
> > I doubt your doubting.  It works.
> 
> I'm suprised.  Sorry once again for the mis-information, (heh, but at
> least it was on-topic, which is somewhat amasing for this mailing list
> :-) ).  Is there a concious effort to make it compile the kernel, or
> are they aiming for general GCC compliance?

I guess both. See

http://lists.insecure.org/lists/linux-kernel/2002/Oct/6450.html

Also, Intel has for long aimed to make icc on Linux to be as gcc compliant
as possible.


-- v --

v@iki.fi
