Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUFROKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUFROKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFROKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:10:15 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:3233 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265154AbUFROKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:10:12 -0400
Subject: Re: PATCH: Further aacraid work
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, Andi Kleen <ak@muc.de>,
       Anton Blanchard <anton@samba.org>, mark_salyzyn@adaptec.com,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <40D2842F.6090304@pobox.com>
References: <286GI-5y3-11@gated-at.bofh.it> <286Qp-5EU-19@gated-at.bofh.it>
	<m3smcut2z0.fsf@averell.firstfloor.org>
	<20040617205414.GE8705@devserv.devel.redhat.com> 
	<40D2842F.6090304@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 09:07:14 -0500
Message-Id: <1087567647.1752.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 00:57, Jeff Garzik wrote:
> James and BenH discussed a solution at the DMA level, but I don't think 
> anything ever happened.

Actually, yes it did.  I have the patches but they depend on another bio
change which is still making its way through the process.

James


