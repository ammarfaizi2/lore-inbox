Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSIPBKH>; Sun, 15 Sep 2002 21:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSIPBKC>; Sun, 15 Sep 2002 21:10:02 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:32764
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318366AbSIPBJl>; Sun, 15 Sep 2002 21:09:41 -0400
Subject: Re: vesafb one pixel left?!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerhard Mack <gmack@innerfire.net>
Cc: John Levon <movement@marcelothewonderpenguin.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209151718320.15427-100000@innerfire.net>
References: <Pine.LNX.4.44.0209151718320.15427-100000@innerfire.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 16 Sep 2002 02:16:22 +0100
Message-Id: <1032138983.26911.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-15 at 22:20, Gerhard Mack wrote:
> I could be mistaken but I seem to recall that problem with DOS as well
> afik vesa tends to be a bit lossy due to some sort of design problem.

Shouldn't be but X at least can leave cards in a state vesa can't
handle. For one example X leaves my sis6326 in a state that takes a
power off to get vesa back working

