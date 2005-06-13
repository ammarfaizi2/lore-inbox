Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVFMPF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVFMPF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFMPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:05:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16816 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261592AbVFMPFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:05:16 -0400
Date: Mon, 13 Jun 2005 16:05:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050613150509.GA30780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
	Andrew Morton <akpm@osdl.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20050530150950.GA14351@gmail.com> <1117467248.4913.9.camel@mulgrave> <20050530160147.GD14351@gmail.com> <1117477040.4913.12.camel@mulgrave> <20050530190716.GA9239@gmail.com> <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118674783.5079.9.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 09:59:43AM -0500, James Bottomley wrote:
> > Hello, I have applied your two patches against 2.6.12-rc6 (the 
> > http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff and the last
> > one you sent per email) and I get this now :
> 
> Actually, the kernel appears to be wrong:
> 
> > Linux version 2.6.12-rc5 (root@gregoire) (gcc version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #4 Mon Jun 6 20:29:04 CEST 2005

Although it's doubtfull this causes it, this is a compile fully of totally
broken patches.  Please use a proper compile instead of the Gentoo
whackopatchotree.

