Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSILUuZ>; Thu, 12 Sep 2002 16:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSILUuZ>; Thu, 12 Sep 2002 16:50:25 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:9464 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317355AbSILUuY>; Thu, 12 Sep 2002 16:50:24 -0400
Subject: RE: Killing/balancing processes when overcommited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.44.0209121441060.10048-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209121441060.10048-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 21:55:47 +0100
Message-Id: <1031864147.2902.119.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 21:43, Thunder from the hill wrote:
> > Ulimit won't help you one iota
> 
> Why so pessimistic? You can ban users using ulimit, as you know. (You will 
> always remember when you wake up and your memory is ulimited to 1MB.)

Because I've run real world large systems before. Ulimit is at best a
handy little toy for stopping web server accidents.

