Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSILXDZ>; Thu, 12 Sep 2002 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSILXDZ>; Thu, 12 Sep 2002 19:03:25 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:27384
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318601AbSILXDY>; Thu, 12 Sep 2002 19:03:24 -0400
Subject: RE: Killing/balancing processes when overcommited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.44.0209121514330.10048-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209121514330.10048-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 13 Sep 2002 00:08:37 +0100
Message-Id: <1031872117.6972.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 22:15, Thunder from the hill wrote:
> Hi,
> 
> On 12 Sep 2002, Alan Cox wrote:
> > Because I've run real world large systems before. Ulimit is at best a
> > handy little toy for stopping web server accidents.
> 
> Only if you assume that a bunch of users tries very hard to use up all the 
> resources...

You've never run a large machine have you

