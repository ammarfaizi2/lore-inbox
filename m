Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGMO3Y>; Sat, 13 Jul 2002 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSGMO3X>; Sat, 13 Jul 2002 10:29:23 -0400
Received: from 62-190-217-195.pdu.pipex.net ([62.190.217.195]:7430 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S314080AbSGMO3W>; Sat, 13 Jul 2002 10:29:22 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207131436.PAA00422@darkstar.example.net>
Subject: Re: IDE/ATAPI in 2.5
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 13 Jul 2002 15:36:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, thunder@ngforever.de, schilling@fokus.gmd.de
In-Reply-To: <1026574369.13886.2.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jul 13, 2002 04:32:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Both of the existing drivers would become the legacy driver, and a new one would be forked from the legacy code, which abstracts the physical interface altogether.  Eventually, we're going to have IDE, ATAPI (I.E. mostly non-disk IDE devices), SCSI, SASI(maybe :-)), USB, FireWire, Bluetooth, etc.  The number of interfaces is just going to grow and grow.
> 
> I look forward to seeing your patches

... if only I could get that 'Hello World' code debugged I'd be well on my way, eh?  :-)
