Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318964AbSIIVDM>; Mon, 9 Sep 2002 17:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318965AbSIIVDM>; Mon, 9 Sep 2002 17:03:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4336 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318964AbSIIVC5>; Mon, 9 Sep 2002 17:02:57 -0400
Subject: Re: opps 2.4.20-pre5-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tabris <tabris@tabris.net>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200209081753.14660.tabris@tabris.net>
References: <20020908203126.GA11475@the-penguin.otak.com> 
	<200209081753.14660.tabris@tabris.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 22:09:27 +0100
Message-Id: <1031605767.29793.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 22:53, Tabris wrote:
> This is an interaction of the rmap vm patch (included in -ac) and the nVidia 
> binary driver. I have run into this myself, tho it doesn't usually cause a 

Only he isnt using the Nvidia driver. Somehow he got a page that should
not have been blown away because someone still had maps to it.

