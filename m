Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274916AbTGaXOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274915AbTGaXOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:14:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S274913AbTGaXOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:14:30 -0400
Date: Fri, 1 Aug 2003 00:14:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'Jens Axboe'" <axboe@suse.de>, "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: Re: [ANNOUNCE] megaraid 2.00.6 patch for kernels without hostlock
Message-ID: <20030731231428.GP22222@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E570185F3CF@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F3CF@EXA-ATLANTA.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 05:10:50PM -0400, Mukker, Atul wrote:
> 
> Well, that's definitely a good idea. Expect a new driver with this change.
> BTW, is there a kernel version beyond which all versions would support per
> host lock, and I mean a 2.4.x kernel :-)

that's a pretty dangerous change to make to a stable kernel.  much better
to work on stabilising 2.6.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
