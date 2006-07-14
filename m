Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWGNMke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWGNMke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 08:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWGNMke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 08:40:34 -0400
Received: from ns.suse.de ([195.135.220.2]:64185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161102AbWGNMkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 08:40:33 -0400
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI-Express AER implemetation: aer howto document
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	<1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Jul 2006 14:40:30 +0200
In-Reply-To: <1152854749.28493.286.camel@ymzhang-perf.sh.intel.com>
Message-ID: <p73fyh4pdfl.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> writes:
> 
> Patch 1 consists of the pciaer-howto.txt document.

The user documentation is still not good. Too hidden, too short.

Best you split it into a user and developer part and user needs to be
far more extensive.

-Andi
