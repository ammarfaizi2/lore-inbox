Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWGGIFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWGGIFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWGGIFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:05:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37297 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932065AbWGGIFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:05:16 -0400
Date: Fri, 7 Jul 2006 10:03:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: christoph@lameter.com, schwidefsky@de.ibm.com, geraldsc@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vmstat: export all_vm_events()
Message-ID: <20060707080322.GD9480@osiris.boeblingen.de.ibm.com>
References: <20060707074525.GA9480@osiris.boeblingen.de.ibm.com> <20060707005712.1560d1cf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707005712.1560d1cf.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 12:57:12AM -0700, Andrew Morton wrote:
> On Fri, 7 Jul 2006 09:45:25 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > +EXPORT_SYMBOL(all_vm_events);
> 
> I converted this to _GPL if that's OK.
> 
> Don't know why, really.  Just to save wear and tear on Arjan's email client
> I guess.

Fine with me. I just tried to be consistent with the rest of the exports in
vmstat.c.
