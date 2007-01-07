Return-Path: <linux-kernel-owner+w=401wt.eu-S964836AbXAGSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbXAGSaA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbXAGSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:30:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36426 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836AbXAGS37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:29:59 -0500
Date: Sun, 7 Jan 2007 18:29:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070107182946.GA8158@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>,
	kvm-devel <kvm-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>
References: <20070105215223.GA5361@elte.hu> <20070106130817.GB5660@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106130817.GB5660@ucw.cz>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 01:08:18PM +0000, Pavel Machek wrote:
> Does this make Xen obsolete? I mean... we have xen patches in suse
> kernels, should we keep updating them, or just drop them in favour of
> KVM?

After all the Novell Marketing Hype you'll probably have to keep Xen ;-)
Except for that I suspect a paravirt kvm or lhype might be the better
hypervisor choice in the long term.

