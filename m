Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263739AbSJGXK7>; Mon, 7 Oct 2002 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263497AbSJGXJ2>; Mon, 7 Oct 2002 19:09:28 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:1782 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263731AbSJGXIk>; Mon, 7 Oct 2002 19:08:40 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
       giduru@yahoo.com, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021007230109.GI3485@conectiva.com.br>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
	<20021005205238.47023.qmail@web13201.mail.yahoo.com>
	<20021005.212832.102579077.davem@redhat.com>
	<20021007092212.B18610@home.com>  <20021007230109.GI3485@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 00:23:27 +0100
Message-Id: <1034033007.26504.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 00:01, Arnaldo Carvalho de Melo wrote:
to tweak
> > the values exactly how we want in a specific application.  The tweaking
> > options can be buried under advanced kernel options with the appropriate
> > disclaimers about shooting yourself in the foot.
>  
> That is how I think it should be done, yes.

Submitting dprintk() seems like a great starting point. I've also got
some patches in the archive someone sent that allows you to configure
out the #! exec stuff

