Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277654AbRJRJ4d>; Thu, 18 Oct 2001 05:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277655AbRJRJ4X>; Thu, 18 Oct 2001 05:56:23 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:63990 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S277654AbRJRJ4N>;
	Thu, 18 Oct 2001 05:56:13 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/interrupts on 2.4.13-1
In-Reply-To: <Pine.LNX.4.10.10110180004040.31416-100000@coffee.psychology.mcmaster.ca>
From: Jens Gecius <jens@gecius.de>
Date: 18 Oct 2001 05:56:47 -0400
In-Reply-To: <Pine.LNX.4.10.10110180004040.31416-100000@coffee.psychology.mcmaster.ca> (Mark Hahn's message of "Thu, 18 Oct 2001 00:06:22 -0400 (EDT)")
Message-ID: <87hesxb7a8.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Mark Hahn <hahn@physics.mcmaster.ca> writes:

> > MIS:       3690
> > 
> > Especially the last makes me curious: does MIS mean "missed"? And:
> 
> no.  see the excellent comment in arch/i386/kernel/io_apic.c near irq_mis_count

That IS an excellent comment. Thanks for pointing it out.

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097
