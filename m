Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262897AbSJLLdl>; Sat, 12 Oct 2002 07:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJLLdk>; Sat, 12 Oct 2002 07:33:40 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18610 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262897AbSJLLdj>; Sat, 12 Oct 2002 07:33:39 -0400
Subject: Re: [Linux-streams] Re: [PATCH] Re: export of sys_call_tabl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bidulock@openss7.org
Cc: Ole Husgaard <osh@sparre.dk>, Christoph Hellwig <hch@infradead.org>,
       David Grothe <dave@gcom.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LiS <linux-streams@gsyc.escet.urjc.es>, davem@redhat.com
In-Reply-To: <20021012035642.B14955@openss7.org>
References: <5.1.0.14.2.20021010115616.04a0de70@localhost>
	<4386E3211F1@vcnet.vc.cvut.cz>
	<5.1.0.14.2.20021010115616.04a0de70@localhost>
	<20021010182740.A23908@infradead.org>
	<5.1.0.14.2.20021010140426.0271c6a0@localhost>
	<20021011180209.A30671@infradead.org> <20021011142657.B32421@openss7.org>
	<3DA78926.FB2299A@sparre.dk>  <20021012035642.B14955@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 12:51:05 +0100
Message-Id: <1034423465.14314.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 10:56, Brian F. G. Bidulock wrote:
> Ole,
> 
> I don't think that exporting putpmsg and getpmsg as _GPL will
> stop proprietary modules from being linked with LiS.  LiS exports
> its symbols on a different basis.  There is no need for a proprietary
> module using LiS to access putpmsg or getpmsg or the syscall
> registration facility for that matter.  Is you concern that LiS
> using a _GPL only facility will force GPL on modules linked with LiS
> even though LiS is LGPL?

The _GPL is just to help people and guide them. It doesn't alter what is
and is not an offence under copyright law.

