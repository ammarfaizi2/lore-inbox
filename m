Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUIYVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUIYVan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUIYVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:30:43 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:21979 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267359AbUIYVal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:30:41 -0400
Date: Sat, 25 Sep 2004 23:30:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3 breaks amanda (was: 2.6.9-rc2-mm3)
Message-ID: <20040925213039.GB480@merlin.emma.line.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040924014643.484470b1.akpm@osdl.org> <20040925172223.GA14562@merlin.emma.line.org> <200409251437.17017.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409251437.17017.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Gene Heskett wrote:

> Sounds to me as if amanda isn't setup correctly.  its working here 
> just fine with 1 server and 2 clients, one of which is the server 
> itself.  Running version 2.4.5b1-20040915 to virtual tapes on a big 
> disk.

Is Amanda set up incorrectly if SuSE's default 2.6.5 kernel and a
vanilla 2.6.7 work well even with clients, but 2.6.9-rc2-mm1 to -mm3
versions fail at the same task, with the same Amanda installation and
software?

I only exchanged the kernel, nothing else. Same hardware, same
user-space software.

I doubt that it's Amanda's configuration. I'd expect a "stable"
2.6.9-whatever kernel to be backwards compatible with its 2.6.X
predecessors.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
