Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSCOKyW>; Fri, 15 Mar 2002 05:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCOKyN>; Fri, 15 Mar 2002 05:54:13 -0500
Received: from mail.emit.pl.108.205.195.in-addr.arpa ([195.205.108.125]:63754
	"EHLO mail.emit.pl") by vger.kernel.org with ESMTP
	id <S289556AbSCOKyA>; Fri, 15 Mar 2002 05:54:00 -0500
Date: Fri, 15 Mar 2002 11:54:38 +0100
From: Ian Carr-de Avelon <avelon@emit.pl>
Message-Id: <200203151054.LAA02530@mail.emit.pl>
Subject: 3com switch with 2.4.17 
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 486 which runs as a router, and I want to change to 2.4. After
boot and working out which order the ether cards are now found in, everything
is OK except I can't ping PCs connected to a 3com switch, which connects
to a ne2k-pci RTL-8029 card in the 486 via a hub. PCs directly connected to
the hub ping OK. 
Does this ring any bells as to why this could be OK with a 2.2.13 kernel
but broken with 2.4.17?
My troubleshooting is normally a) check it electricaly (obviously OK as
it has worked with 2.2.13 for months) then check it pings.
How can I look further into this? eg looking at ethernet packets instead
of TCP/IP packets?
Yours
Ian
