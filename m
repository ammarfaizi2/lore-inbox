Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVIHECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVIHECV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 00:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVIHECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 00:02:21 -0400
Received: from colo.lackof.org ([198.49.126.79]:59606 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751257AbVIHECV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 00:02:21 -0400
Date: Wed, 7 Sep 2005 22:08:20 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brian King <brking@us.ibm.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050908040820.GA14170@colo.lackof.org>
References: <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com> <20050903193958.GB30579@colo.lackof.org> <17182.32625.930500.874251@cargo.ozlabs.ibm.com> <20050907145818.GA25409@colo.lackof.org> <17183.27667.47675.454393@cargo.ozlabs.ibm.com> <20050908012116.GB2065@colo.lackof.org> <431FAA7A.90503@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431FAA7A.90503@us.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:05:30PM -0500, Brian King wrote:
> I reverted the patch to use a spinlock and added a comment.
> How does this look?

Fine with me. Ball is in akpm/Paul's court.

grant
