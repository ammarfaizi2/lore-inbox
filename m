Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268071AbUHKOuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268071AbUHKOuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUHKOuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:50:13 -0400
Received: from fmr11.intel.com ([192.55.52.31]:62389 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S268071AbUHKOuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:50:10 -0400
Subject: Re: Allow userspace do something special on overtemp
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040811090622.GC674@elf.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz>
	 <1092215024.2816.8.camel@laptop.fenrus.com>
	 <20040811090622.GC674@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1092235779.5028.93.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Aug 2004 10:49:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 05:06, Pavel Machek wrote:
> Hi!
> 
> > >.adds possibility to react to
> > > critical overtemp: it tries to call /sbin/overtemp, and only if
> that fails calls /sbin/poweroff.

Does /sbin/overtemp exist anyplace, or is this a proposal
to create it?  What might it do?

thanks,
-Len

