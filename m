Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbUDFN4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUDFNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:54:24 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:18352 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263834AbUDFNxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:53:16 -0400
Date: Tue, 6 Apr 2004 14:50:32 +0100
From: Dave Jones <davej@redhat.com>
To: Bjoern Michaelsen <bmichaelsen@gmx.de>
Cc: linux-kernel@vger.kernel.org, volker.hemmann@heim9.tu-clausthal.de
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406134709.GB32405@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org, volker.hemmann@heim9.tu-clausthal.de
References: <20040406031949.GA8351@lord.sinclair>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406031949.GA8351@lord.sinclair>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:19:49AM +0200, Bjoern Michaelsen wrote:

 > I wrote a patch against 2.6.5 to let the SiS 746 take advantage
 > of the SiS 648 patches too.
 > http://bugzilla.kernel.org/show_bug.cgi?id=2327

That and a few others are in the pending queue which I'll push
when Linus gets back. See http://www.codemonkey.org.uk/projects/bitkeeper/agpgart/
for the patch-of-the-day from bk://linux-dj.bkbits.net/agpgart

In particular theres an additional fix for SiS users, I broke
AGPv2 support in the previous fix that went into 2.6.5

		Dave

