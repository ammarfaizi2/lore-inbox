Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbSI0TGP>; Fri, 27 Sep 2002 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSI0TGP>; Fri, 27 Sep 2002 15:06:15 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:28151 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262581AbSI0TGN>; Fri, 27 Sep 2002 15:06:13 -0400
Subject: Re: [patch] stradis fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: laredo@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020927183341.GA416@cathedrallabs.org>
References: <20020927172230.GQ20649@cathedrallabs.org>
	<1033149332.16726.3.camel@irongate.swansea.linux.org.uk> 
	<20020927183341.GA416@cathedrallabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 20:17:04 +0100
Message-Id: <1033154224.16726.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 19:33, Aristeu Sergio Rozanski Filho wrote:
> stradis.c: In function `saa_ioctl':
> stradis.c:1340: warning: passing arg 1 of `__constant_copy_to_user' makes
> pointer from integer without a cast
> stradis.c:1340: warning: passing arg 1 of `__generic_copy_to_user' makes
> pointer from integer without a cast
> (snip)
> am I missing something?

Maybe you should ask why they are integers and what else is wrong ?

