Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262797AbSJEXKU>; Sat, 5 Oct 2002 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262798AbSJEXKU>; Sat, 5 Oct 2002 19:10:20 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:13556 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262797AbSJEXKT>; Sat, 5 Oct 2002 19:10:19 -0400
Subject: Re: 2.5.40: some results...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005182451.B15663@animx.eu.org>
References: <20021005214508.IKVD1253.amsfep12-int.chello.nl@there> 
	<20021005182451.B15663@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 00:24:22 +0100
Message-Id: <1033860262.4441.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 23:24, Wakko Warner wrote:
> I can't get it to compile for me.  ide and serial both bomb out.  I'm
> compiling as a module for both of these (I was going to test on an nfs
> root/netboot machine and I modularize EVERYTHING! =)

Known for IDE. About number 5000 on the IDE priority list.

