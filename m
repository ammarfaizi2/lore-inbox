Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287866AbSA1NFX>; Mon, 28 Jan 2002 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSA1NFD>; Mon, 28 Jan 2002 08:05:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287866AbSA1NEs>; Mon, 28 Jan 2002 08:04:48 -0500
Subject: Re: Don't use dbench for benchmarks
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 28 Jan 2002 13:17:02 +0000 (GMT)
Cc: alex14641@yahoo.com (Alex Davis), linux-kernel@vger.kernel.org
In-Reply-To: <E16VAOw-00009Y-00@starship.berlin> from "Daniel Phillips" at Jan 28, 2002 12:56:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VBeg-0000YT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I must be having a bad day, I can only think of irritable things to post.
> Continuing that theme: please don't use dbench for benchmarks.  At all.
> It's an unreliable indicator of anything in particular except perhaps
> stability.  Please, use something else for your benchmarks.

Im not 100% sure that is the case. Done 30 or 40 times and done from a 
reboot for the 30-40 pass sequence its quite a passable guide to
both stability and I/O behaviour under some server loads. 

Alan
