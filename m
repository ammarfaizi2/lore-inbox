Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVK3PO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVK3PO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVK3PO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:14:26 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:51925 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751254AbVK3PO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:14:26 -0500
Subject: Re: [PATCH] race condition in procfs
From: Steven Rostedt <rostedt@goodmis.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <121a28810511300641pca9596fl@mail.gmail.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
	 <121a28810511290639g79617c85h@mail.gmail.com>
	 <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
	 <121a28810511300641pca9596fl@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 10:14:12 -0500
Message-Id: <1133363652.25340.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 15:41 +0100, Grzegorz Nosek wrote:
> 
> I'm lost. Any assistance will be invaluable.

OK, Remove your patches, run the system where you can capture the log,
and provide a full output of the oops.  Make sure you have
CONFIG_KALLSYMS set.

-- Steve


