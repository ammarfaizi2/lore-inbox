Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTDRXiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTDRXiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:38:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56304 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263301AbTDRXiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:38:16 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304182350.h3INoC728630@devserv.devel.redhat.com>
Subject: Re: My P3 runs at.... zero Mhz (bug rpt)
To: pekon@informatics.muni.cz (Petr Konecny)
Date: Fri, 18 Apr 2003 19:50:12 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk (Dave Jones),
       thunder7@xs4all.nl (Jurriaan), jgarzik@pobox.com (Jeff Garzik),
       alan@redhat.com (Alan Cox)
In-Reply-To: <qwwvfxb1nvu.fsf@decibel.fi.muni.cz> from "Petr Konecny" at Ebr 18, 2003 11:44:53 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It does not help me with 2.5.67-ac2 + pcmcia patch. I get 0.000 MHz,
> 589.82 BogoMIPS with or without CPUFreq. It did the same thing with
> 2.5.67-ac1 (did not test w/o CPUFreq).

Its a bug in the mach- patches. Someone sent a fix to l/k

