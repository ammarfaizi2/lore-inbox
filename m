Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267572AbSLSGvY>; Thu, 19 Dec 2002 01:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLSGvY>; Thu, 19 Dec 2002 01:51:24 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:6929
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S267572AbSLSGvY>; Thu, 19 Dec 2002 01:51:24 -0500
Subject: Re: modules oops in 2.5.52
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219063839.40F322C080@lists.samba.org>
References: <20021219063839.40F322C080@lists.samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1040281164.1709.5.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 22:59:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 21:55, Rusty Russell wrote:
> Yes, it would be a problem.  But I don't think that's the problem
> here, and I don't think it can actually happen (it's a pretty insane
> idea).
> 
> BTW, I can't reproduce your problem, maybe because I can't unload
> parport_pc here:
> 
> Module parport cannot be unloaded due to unsafe usage in drivers/parport/init.c:234
> Module parport_pc cannot be unloaded due to unsafe usage in drivers/parport/parport_pc.c:1239

Well, I don't have any problem unloading it.  It doesn't show any
messages or other warnings.  It also doesn't crash any more, so I'm not
sure what's happening...

	J

