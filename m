Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbSJDQkH>; Fri, 4 Oct 2002 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262475AbSJDQkG>; Fri, 4 Oct 2002 12:40:06 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:59387 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262474AbSJDQkF>; Fri, 4 Oct 2002 12:40:05 -0400
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 17:53:46 +0100
Message-Id: <1033750426.31839.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 17:33, Linus Torvalds wrote:
> They are still in use by a lot of drivers.. I hate to break even more 
> drivers at this point in 2.5.x, and so quite frankly I'd rather just do 
> this in early 2.7.x instead. Unless somebody really steps up to the plate 
> and also fixes the drivers ("it's a ton of fun, and imagine all the 
> adoration you'll get from teenage girls/boys/ninja turtles for doing it")

Ermm Greg fixed the drivers using it too.

Alan

