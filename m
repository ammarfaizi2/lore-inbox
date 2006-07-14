Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWGNHUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWGNHUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWGNHUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:20:38 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:9657 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161066AbWGNHUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:20:37 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <1152835150.31372.23.camel@shinybook.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=iso-8859-15
Date: Fri, 14 Jul 2006 08:20:19 +0100
Message-Id: <1152861620.6977.3.camel@insmouth>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 192.168.1.176
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: Kernel headers git tree
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 00:59 +0100, David Woodhouse wrote:
> At http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git
> there's a git tree which contains the sanitised exported headers for all
> architectures -- basically the result of 'make headers_install'.
> 
> It tracks Linus' kernel tree, by means of some evil scripts.¹
> 
> Only commits in Linus' tree which actually affect the exported result
> should have an equivalent commit in the above tree, which means that any
> changes which affect userspace should be clearly visible for review.

It might be useful to append the commit checksum from Linus' tree to the
comments so it is easier to backtrack to the original commit.

Ian. 
-- 
Ian Campbell

Your step will soil many countries.

