Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310613AbSCPUky>; Sat, 16 Mar 2002 15:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310622AbSCPUks>; Sat, 16 Mar 2002 15:40:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310602AbSCPUk3>; Sat, 16 Mar 2002 15:40:29 -0500
Subject: Re: debugging eth driver
To: pmanolov@lnxw.com (Petko Manolov)
Date: Sat, 16 Mar 2002 20:56:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C93945A.8040305@lnxw.com> from "Petko Manolov" at Mar 16, 2002 10:52:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mLDs-00078o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Keep an eye on /proc/net/snmp
> 
> It isn't very readable format..  Any other way or i have to
> read the code and see what the messages mean?

Read the SNMP specification - its dumped by standard SNMP MIB entry
