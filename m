Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262749AbSJGXDO>; Mon, 7 Oct 2002 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbSJGXDN>; Mon, 7 Oct 2002 19:03:13 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:63733 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262749AbSJGXDL>; Mon, 7 Oct 2002 19:03:11 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: simon@baydel.com, Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021007225927.GH3485@conectiva.com.br>
References: <3DA16A9B.7624.4B0397@localhost>
	<3DA1D07E.10994.142437C@localhost>  <20021007225927.GH3485@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 00:18:34 +0100
Message-Id: <1034032714.26504.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 23:59, Arnaldo Carvalho de Melo wrote:

> Well, ask a lawyer, but Linux is licensed under the GPL _plus_ some
> extra clauses, for instance it is ok, AFAIK, to ship a binary only module
> that restrains itself to using non EXPORT_SYMBOL_GPL exported symbols.

Nope its GPL, barring the rules for user apps - check the COPYING file.
Nvidia would claim their driver is a seperate work, and as such since
its not a derivative work is none of our business

