Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSJYPIU>; Fri, 25 Oct 2002 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJYPIU>; Fri, 25 Oct 2002 11:08:20 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20422 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261385AbSJYPIT>; Fri, 25 Oct 2002 11:08:19 -0400
Subject: Re: VIA EPIA problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Serge <sergeyssv@mail.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210251900.02065.sergeyssv@mail.ru>
References: <200210251900.02065.sergeyssv@mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 16:31:58 +0100
Message-Id: <1035559918.13032.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 16:00, Serge wrote:
> Mainboard VIA EPIA mini-ITX with VIA C3 800 Mhz or 500 Mhz
> 
> I faced with strange problem connected to this mainboard.
> 
> Kernel crashed when attempt to configrue net interface. 

Are you using an early cubid 2677 case or another very small power
supply. There are known problems with the ethernet if you are under
current

