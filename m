Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWJJV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWJJV3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWJJV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:29:05 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:11466 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030432AbWJJV3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:29:02 -0400
Date: Tue, 10 Oct 2006 22:28:53 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
Message-ID: <20061010212853.GC31972@srcf.ucam.org>
References: <1160417982.5142.45.camel@funkylaptop> <20061010103910.GD31598@elf.ucw.cz> <1160476889.3000.282.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160476889.3000.282.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:41:28PM +0200, Arjan van de Ven wrote:

> "fix" for some value of the word.
> The problem is that this is very much against the spec, and also quite
> likely breaks a bunch of machines...

It works fine under Windows, which suggests that the Windows behaviour 
is to reenable the bit. I wouldn't really expect any existing hardware 
to expect any other sort of behaviour.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
