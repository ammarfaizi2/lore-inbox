Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSCTATg>; Tue, 19 Mar 2002 19:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCTAT0>; Tue, 19 Mar 2002 19:19:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12819 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293187AbSCTATU>; Tue, 19 Mar 2002 19:19:20 -0500
Subject: Re: reading your email via tcpdump
To: root@chaos.analogic.com
Date: Wed, 20 Mar 2002 00:34:32 +0000 (GMT)
Cc: adilger@clusterfs.com (Andreas Dilger), jjasen1@umbc.edu (John Jasen),
        mikeg@wen-online.de (Mike Galbraith),
        vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.3.95.1020319151601.4151A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 19, 2002 03:19:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nU3k-0000oJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The data sent/received on the network is precious. You will not have
> any 'extra' data on its end except for possibly a single byte if the
> data didn't have an even length. Note that these things are checksummed
> and also CRCed in the hardware.

Wrong for ethernet. Ethernet has a minimum frame size

Alan
