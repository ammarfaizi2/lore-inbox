Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311861AbSCNXSm>; Thu, 14 Mar 2002 18:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311865AbSCNXSc>; Thu, 14 Mar 2002 18:18:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48901 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311861AbSCNXSS>; Thu, 14 Mar 2002 18:18:18 -0500
Subject: Re: VFS mediator?
To: Simon.Richter@phobos.fachschaften.tu-muenchen.de (Simon Richter)
Date: Thu, 14 Mar 2002 23:33:34 +0000 (GMT)
Cc: jbarker@ebi.ac.uk (Jonathan Barker), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203150006550.6903-100000@phobos> from "Simon Richter" at Mar 15, 2002 12:09:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lej0-0002FE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have experimented with using NFS for that -- start a local daemon that
> exports a virtual filesystem and mount that. The great bonus is that it's
> platform independent -- it works on Solaris, HP-UX and even Ultrix just as
> well. Other projects have become more important, however, and I haven't
> finished it. If you're interested, drop me a line.

There are several of these and also some folks using the coda interface
to do the same work, as the coda interface is sometimes better suited. 

