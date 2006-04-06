Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWDFK2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDFK2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWDFK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:28:19 -0400
Received: from www.osadl.org ([213.239.205.134]:1461 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932083AbWDFK2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:28:19 -0400
Subject: Re: 2.6.16-rt11: Hires timer makes sleep wait far too long
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604050021.k350LnVF029703@auster.physics.adelaide.edu.au>
References: <200604050021.k350LnVF029703@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 12:28:43 +0200
Message-Id: <1144319324.5344.688.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On Wed, 2006-04-05 at 09:51 +0930, Jonathan Woithe wrote:
>   ENABLING IO-APIC IRQs
>   ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
>   Event source pit new caps set: 05
>   Event source lapic installed with caps set: 02
>   :
>   Time: tsc clocksource has been installed.
>   hrtimers: Switched to high resolution mode CPU 0
>   :
>   Time: acpi_pm clocksource has been installed.
>   hrtimers: Switched to high resolution mode CPU 0

Nothing wrong so far. I have to find a test box with pm timer to get
some more info.

	tglx


