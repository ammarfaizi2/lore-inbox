Return-Path: <linux-kernel-owner+w=401wt.eu-S1754492AbWLRTys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbWLRTys (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754493AbWLRTys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:54:48 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49908 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492AbWLRTyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:54:47 -0500
Date: Mon, 18 Dec 2006 20:54:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: jidanni@jidanni.org
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-parameters.txt: expand APIC
In-Reply-To: <E1GwIj5-0000iP-KJ@jidanni.org>
Message-ID: <Pine.LNX.4.61.0612182053260.29144@yvahk01.tjqt.qr>
References: <E1GwIj5-0000iP-KJ@jidanni.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>kernel-parameters.txt says what ACPI and APM stand for, but not APIC.

Advanced PIC, most likely. http://en.wikipedia.org/wiki/APIC will tell 
more.

>Also there give some basic apm related parameters, instead of just
>saying see apm.c, which the user is less likely to have handy than
>kernel-parameters.txt.

As always, patches welcome :)


	-`J'
-- 
