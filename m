Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUAOPuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUAOPuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:50:05 -0500
Received: from [213.226.134.105] ([213.226.134.105]:27606 "EHLO mx.ktv.lt")
	by vger.kernel.org with ESMTP id S264325AbUAOPuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:50:01 -0500
Date: Thu, 15 Jan 2004 17:42:34 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
To: linux-kernel@vger.kernel.org
Cc: Cheng Huang <cheng@cs.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: INLINE
References: <Pine.GSO.4.58.0401150308350.1943@siesta.cs.wustl.edu>
 <20040115114922.GI1254@edu.joroinen.fi>
In-Reply-To: <20040115114922.GI1254@edu.joroinen.fi>
X-Mailer: Mahogany 0.65.0 'Claire', compiled for Linux 2.4.18-rc4 i686
Message-Id: <20040115154755.C9B835D99@mx.ktv.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 13:49:22 +0200 Pasi Kärkkäinen <pasik@iki.fi> wrote:

> On Thu, Jan 15, 2004 at 03:17:12AM -0600, Cheng Huang wrote:
> > I have to use kernel 2.4.18 because I need to install KURT (realtime
> > linux) with it. However, my system hangs on boot with the following
> > message:
> 
> I think there has been a lot of bug fixes in the latest 2.4 kernels for
> promise cards.
> 
> I'm running promise ultra133-tx2 successfully with 2.4.22 kernel.
> 
> Merge the promise driver from later 2.4.x kernels to 2.4.18 and recompile? 

When I used 2.4.18 I had Andre's ide.2.4.18-rc1.02152002.patch.bz2
applied.

Regards,
Nerijus

