Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbSJLLbu>; Sat, 12 Oct 2002 07:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262897AbSJLLbu>; Sat, 12 Oct 2002 07:31:50 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16306 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262894AbSJLLbt>; Sat, 12 Oct 2002 07:31:49 -0400
Subject: Re: [lart] /bin/ps output
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0210120054030.22735-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0210120054030.22735-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Oct 2002 12:49:10 +0100
Message-Id: <1034423350.14314.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 04:55, Rik van Riel wrote:
> On Fri, 11 Oct 2002, David S. Miller wrote:
> 
> 	[ 8 gazillion kernel threads ]
> 
> > We could make them threads of process 0 :-)
> 
> That was my first thought too, but on second thought I think we've
> got an excessive amount of kernel threads and should do something
> about that...

Migration workqueues ?

