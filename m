Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTLEXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbTLEXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:36:27 -0500
Received: from gemini.smart.net ([205.197.48.109]:36625 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S264873AbTLEXgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:36:22 -0500
Message-ID: <3FD115C7.1A3C7CC3@smart.net>
Date: Fri, 05 Dec 2003 18:33:27 -0500
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 : timeouts and lost interrupts using IDE-SCSI
References: <YImw.6Dc.5@gated-at.bofh.it> <20031204170912.6075f36e.kristian.peters@korseby.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Peters wrote:
> 
> Jimmie Mayfield <mayfield+kernel@sackheads.org> schrieb:
> > Since upgrading from 2.4.20 to 2.4.23, I can no longer mount my ATAPI CDROM and
> > CDR/W drives using IDE-SCSI.  Attempts to mount those drives result in
> > lost interrupts messages:
> 
> That is ... intended. 

Huh?  Losing interrupts is intended?


Daniel
-- 
Daniel Barclay
dsb@smart.net
