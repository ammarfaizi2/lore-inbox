Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVKEAqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVKEAqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKEAqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:46:52 -0500
Received: from ozlabs.org ([203.10.76.45]:10725 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751392AbVKEAqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:46:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17260.244.435084.466507@cargo.ozlabs.ibm.com>
Date: Sat, 5 Nov 2005 11:46:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: linas@austin.ibm.com, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
In-Reply-To: <20051105002842.GB22574@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org>
	<20051104221437.GA20004@kroah.com>
	<17259.63473.450876.276151@cargo.ozlabs.ibm.com>
	<20051105002842.GB22574@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Can I take 15, 16, 27-32 now without the ppc64 patches dying without it?

Sorry, I'm having trouble parsing that.  If you mean, will it break
ppc64 if you send those patches to Linus before the ppc64 bits get in,
the answer is no it won't, please send them on.

Thanks,
Paul.
