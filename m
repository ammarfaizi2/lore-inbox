Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJULoC>; Mon, 21 Oct 2002 07:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJULoB>; Mon, 21 Oct 2002 07:44:01 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:52147 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261327AbSJULoB>; Mon, 21 Oct 2002 07:44:01 -0400
Subject: Re: compile failure in i2o_block.c on 2.5.44
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ken Witherow <ken@krwtech.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210201256100.14962-100000@death>
References: <Pine.LNX.4.44.0210201256100.14962-100000@death>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:05:42 +0100
Message-Id: <1035201942.27309.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-20 at 17:58, Ken Witherow wrote:
> stock 2.5.44 using gcc 3.2

i2o is not yet working in 2.5. People also keep breaking API's it relies
on or removing and touching things so Im leaving it until post Oct 31st
before the i2o stuff gets finished off

