Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752091AbWJNFrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbWJNFrw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbWJNFrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:47:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:19142 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752091AbWJNFrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:47:51 -0400
Date: Fri, 13 Oct 2006 22:47:00 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061014054700.GA13985@kroah.com>
References: <1160780425.4792.275.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610132229230.22133-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:33:04PM -0400, Alan Stern wrote:
> (BTW, can anyone explain quickly what "BIST" means?)

"Built In Self Test"
