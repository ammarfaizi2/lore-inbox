Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSILUaA>; Thu, 12 Sep 2002 16:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSILUaA>; Thu, 12 Sep 2002 16:30:00 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:1272 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317215AbSILUaA>; Thu, 12 Sep 2002 16:30:00 -0400
Subject: RE: Killing/balancing processes when overcommited
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Jim Sibley <jlsibley@us.ibm.com>, linux-kernel@vger.kernel.org,
       Giuliano Pochini <pochini@shiny.it>, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.44.0209121306550.10048-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209121306550.10048-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 21:35:20 +0100
Message-Id: <1031862920.2902.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 20:08, Thunder from the hill wrote:

> These problems can be solved via ulimit. I was referring to things like 
> rsyncd which was blowing up under certain situations, but runs under a 
> trusted account (say UID=0). In order to condemn it you'd need the setup 
> I've mentioned.

Ulimit won't help you one iota

