Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSKOOVc>; Fri, 15 Nov 2002 09:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSKOOVc>; Fri, 15 Nov 2002 09:21:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:3246 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266114AbSKOOVb>; Fri, 15 Nov 2002 09:21:31 -0500
Subject: Re: Dual athlon XP 1800 problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Crooke <dave@convio.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD4CD06.2010009@convio.com>
References: <3DD4CD06.2010009@convio.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 14:54:48 +0000
Message-Id: <1037372088.19971.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 10:31, David Crooke wrote:
> 1. When I first put it together, it would consistenly run OK for a 
> period of 4-5 minutes, quite precisely - no less than 4, no more than 5 
> and then just lock up HARD - no Ctrl-Alt-Del, no kernel panics, nothing. 

Turn off ACPI and APM in the bios as a starter. 

> 3. Tried some BIOS settings (e.g. SMP 1.1 mode) - it DOES NOT like this; 
> any BIOS changes AT ALL (even seemingly harmless ones like Num Lock) 
> appear to mess it up totally, and LILO hangs at "LI" when trying to 
> start. Restored factory defaults.

Make sure you have a current BIOS on dual athlon boxes, the earlier
bioses were not terribly good on the whole. Make sure you have a PS/2
mouse in the mouse port even if you aren;t going to use it

