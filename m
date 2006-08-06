Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWHFJhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWHFJhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 05:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWHFJhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 05:37:23 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:15302 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751330AbWHFJhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 05:37:22 -0400
Date: Sun, 6 Aug 2006 11:31:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jes Sorensen <jes@sgi.com>
cc: Andreas Schwab <schwab@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
In-Reply-To: <44D370ED.2050605@sgi.com>
Message-ID: <Pine.LNX.4.61.0608061126120.28841@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>
 <1154702572.23655.226.camel@localhost.localdomain> <44D35B25.9090004@sgi.com>
 <1154706687.23655.234.camel@localhost.localdomain> <44D36E8B.4040705@sgi.com>
 <je4pws1ofb.fsf@sykes.suse.de> <44D370ED.2050605@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We know that today long is the only one that differs

For "modern architectures" maybe, but older compilers (like Turbo C 
compiler (1990)), int is a 16 bit quantity, and therefore does differ, from 
today's implementations at least.


Jan Engelhardt
-- 
