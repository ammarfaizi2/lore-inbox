Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSLAB4h>; Sat, 30 Nov 2002 20:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLAB4h>; Sat, 30 Nov 2002 20:56:37 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44984 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261370AbSLAB4g>; Sat, 30 Nov 2002 20:56:36 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200212010204.gB1241c12503@devserv.devel.redhat.com>
Subject: Re: Massive problems with 2.4.20 module loading
To: rankincj@yahoo.com (Chris Rankin)
Date: Sat, 30 Nov 2002 21:04:01 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3DE8E271.6090307@yahoo.com> from "Chris Rankin" at Nov 30, 2002 04:08:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well maybe that's his problem and maybe it isn't, but he's not the only 
> person thinking that there's something strange about devfs in 2.4.20. I 
> have a 2.4.20-SMP box that is deadlocking when loading modules via 
> devfs. The NMI watchdog has produced two oopsen for me, which I have 

Could be. I don't test devfs at all
