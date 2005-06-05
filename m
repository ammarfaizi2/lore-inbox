Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVFEPIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFEPIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFEPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:08:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57339 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261587AbVFEPIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:08:11 -0400
Date: Sun, 5 Jun 2005 08:08:06 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <20050605094742.GA8346@elte.hu>
Message-ID: <Pine.LNX.4.10.10506050806440.10127-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Jun 2005, Ingo Molnar wrote:

> i think it would be handy to resurrect ALL_TASKS_PI. It was one of the 
> things that stabilized the sorted list approach so quickly. Nothing 
> beats the coverage of running a full graphical desktop with all the PI 
> code active :-)


I keep wondering why I'm dragging ALL_TASKS_PI around in all my patches,
since it doesn't work. Why not have it on all the time?

Daniel 

