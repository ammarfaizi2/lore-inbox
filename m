Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVLILp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVLILp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVLILp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:45:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750884AbVLILp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:45:27 -0500
Date: Fri, 9 Dec 2005 12:46:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Erik Slagter <erik@slagter.name>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Randy Dunlap <randy_d_dunlap@linux.intel.com>, hch@infradead.org,
       mjg59@srcf.ucam.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209114641.GH26185@suse.de>
References: <20051208133945.GA21633@srcf.ucam.org> <20051208134438.GA13507@infradead.org> <1134062330.1732.9.camel@localhost.localdomain> <43989B00.5040503@pobox.com> <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com> <1134121522.27633.7.camel@localhost.localdomain> <20051209103937.GE26185@suse.de> <1134125145.27633.32.camel@localhost.localdomain> <43996A26.8060700@pobox.com> <1134128127.27633.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134128127.27633.39.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2005, Erik Slagter wrote:
> I case this (still) isn't clear, I am addressing the attitude of "It's
> ACPI so it's not going to be used, period".

The problem seems to be that you are misunderstanding the 'attitude',
which was mainly based on the initial patch sent out which stuffs acpi
directly in everywhere. That seems to be a good trigger for curt/direct
replies.

-- 
Jens Axboe

