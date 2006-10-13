Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWJMJbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWJMJbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWJMJbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:31:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14989 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751032AbWJMJbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:31:55 -0400
Date: Fri, 13 Oct 2006 11:31:49 +0200
From: Martin Mares <mj@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@MIT.EDU>, Alan Stern <stern@rowland.harvard.edu>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <mj+md-20061013.093014.26714.atrey@ucw.cz>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org> <1160701263.4792.179.camel@localhost.localdomain> <1160729427.26091.98.camel@localhost.localdomain> <1160731004.4792.245.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160731004.4792.245.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For example, currently, if I power off the ethernet of my mac, or the
> firewire chip (which are powered off if the module isn't loaded), lspci
> will get the device id and vendor id right ... but won't get the class
> code.

Ehm, you aren't using any recent pciutils, are you? ;-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lottery -- a tax on people who can't do math.
