Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271617AbTGRL7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTGRL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:59:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:58127 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271617AbTGRL66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:58:58 -0400
Date: Fri, 18 Jul 2003 13:13:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718131352.A26546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org> <20030718122304.A23013@infradead.org> <20030718121202.GC6520@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030718121202.GC6520@marowsky-bree.de>; from lmb@suse.de on Fri, Jul 18, 2003 at 02:12:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 02:12:02PM +0200, Lars Marowsky-Bree wrote:
> Please come and attend the multipath session at the Kernel Summit and/or
> the Ottawa Linux Symposium next week to learn why this is a bad idea and
> how it can be done better -> http://www.linuxsymposium.org/

-ENOTIME :)

> However, for backwards compatibility with 2.4, I assume it might still
> be needed in 2.5/2.6, but _only_ with the clear intend of phasing it out
> within 2.6 and dropping it in 2.7.
> 
> QLogic is reasonably good already in that it can be disabled via a
> module parameter (ql2xfailover=0), allowing the higher level solutions
> to operate.

Given that this module never was in 2.4 I don't see clear backwards
compatiblity problems..

