Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSGZJPB>; Fri, 26 Jul 2002 05:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGZJPB>; Fri, 26 Jul 2002 05:15:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24564 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317622AbSGZJPA>; Fri, 26 Jul 2002 05:15:00 -0400
Subject: Re: PATCH: 2.5.28 (resend #1) Q40 keyboard
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Alan Cox <alan@irongate.swansea.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D40B109.1000105@evision.ag>
References: <200207251445.g6PEjs17010417@irongate.swansea.linux.org.uk> 
	<3D40B109.1000105@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:32:26 +0100
Message-Id: <1027679546.13428.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 03:16, Marcin Dalecki wrote:
> Alan Cox wrote:
> > The Q40 keyboard is only found on a Q40..
> > 
> 
> Are you sure it's not simply RS232?

It relies on m68k specific code, so it won't even compile on non Q40
boxes.

