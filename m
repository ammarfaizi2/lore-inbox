Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263529AbUFBPwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUFBPwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFBPu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:50:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263419AbUFBPpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:45:49 -0400
Date: Wed, 2 Jun 2004 11:45:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <40BDF1AC.7070209@shadowconnect.com>
Message-ID: <Pine.LNX.4.53.0406021144280.559@chaos>
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org>
 <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com>
 <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com>
 <40BDDAD9.5070809@shadowconnect.com> <20040602134603.GA8589@havoc.gtf.org>
 <40BDE1BB.3030605@shadowconnect.com> <Pine.LNX.4.53.0406021024400.3280@chaos>
 <40BDF1AC.7070209@shadowconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I asked for the output of `cat /proc/pci` . Unless I get that
information, I can't find the length of the allocation.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


