Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSLOBP7>; Sat, 14 Dec 2002 20:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSLOBP7>; Sat, 14 Dec 2002 20:15:59 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:49615 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266186AbSLOBP6> convert rfc822-to-8bit; Sat, 14 Dec 2002 20:15:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
Date: Sun, 15 Dec 2002 02:23:34 +0100
User-Agent: KMail/1.4.3
Cc: Mikael Pettersson <mikpe@csd.uu.se>
References: <200212150119.CAA02575@harpo.it.uu.se>
In-Reply-To: <200212150119.CAA02575@harpo.it.uu.se>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212150223.34562.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 December 2002 02:19, Mikael Pettersson wrote:

Hi Mikael,

> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
> now hangs during initialisation. 2.2 kernels (with Andre's
> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
> My box has a Seagate STT8000A ATAPI tape drive as hdd;
> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828

ciao, Marc
