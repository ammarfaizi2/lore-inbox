Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVKOV4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVKOV4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVKOV4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:56:17 -0500
Received: from ozlabs.org ([203.10.76.45]:61327 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965031AbVKOV4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:56:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17274.22908.867547.10612@cargo.ozlabs.ibm.com>
Date: Wed, 16 Nov 2005 08:56:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI Error Recovery
In-Reply-To: <20051115175934.GO19593@austin.ibm.com>
References: <20051108234911.GC19593@austin.ibm.com>
	<20051114214703.GG19593@austin.ibm.com>
	<20051115164901.GA12968@kroah.com>
	<20051115175934.GO19593@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas writes:

> ? I'm sorry, I'm crawling the archives, and can't find any threads 
> that haven't already been addressed in the final patchset.

I think someone wanted you to make the bitwise thing an unsigned int
rather than an int.  I don't remember any other changes being
requested, if someone did want something, hopefully they'll chime in
and remind us. :)

Paul.
