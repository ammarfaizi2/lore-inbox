Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277585AbRJREGK>; Thu, 18 Oct 2001 00:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277591AbRJREGA>; Thu, 18 Oct 2001 00:06:00 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:37641 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S277585AbRJREFt>; Thu, 18 Oct 2001 00:05:49 -0400
Date: Thu, 18 Oct 2001 00:06:22 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/interrupts on 2.4.13-1
In-Reply-To: <87n12pbsug.fsf@maniac.gecius.de>
Message-ID: <Pine.LNX.4.10.10110180004040.31416-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MIS:       3690
> 
> Especially the last makes me curious: does MIS mean "missed"? And:

no.  see the excellent comment in arch/i386/kernel/io_apic.c near irq_mis_count


