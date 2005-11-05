Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVKEB2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVKEB2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVKEB2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:28:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:33248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751434AbVKEB2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:28:45 -0500
Date: Fri, 4 Nov 2005 17:28:06 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linas@austin.ibm.com, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/42] PCI Error Recovery for PPC64 and misc device drivers
Message-ID: <20051105012806.GA23675@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104221437.GA20004@kroah.com> <17259.63473.450876.276151@cargo.ozlabs.ibm.com> <20051105002842.GB22574@kroah.com> <17260.244.435084.466507@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17260.244.435084.466507@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 11:46:44AM +1100, Paul Mackerras wrote:
> Greg KH writes:
> 
> > Can I take 15, 16, 27-32 now without the ppc64 patches dying without it?
> 
> Sorry, I'm having trouble parsing that.  If you mean, will it break
> ppc64 if you send those patches to Linus before the ppc64 bits get in,
> the answer is no it won't, please send them on.

Ok, I'll go look at them and see if they can be added to my tree for
testing in -mm before I'll send them to Linus.

thanks,

greg k-h
