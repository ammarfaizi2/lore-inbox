Return-Path: <linux-kernel-owner+w=401wt.eu-S1759968AbWLJEJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759968AbWLJEJo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 23:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759971AbWLJEJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 23:09:44 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:47207 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1759968AbWLJEJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 23:09:43 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: Re: RFC: PCI quirks update for 2.6.16
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Adrian Bunk <bunk@stusta.de>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <45782774.8060002@gentoo.org>
References: <20061207132430.GF8963@stusta.de>  <45782774.8060002@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Sun, 10 Dec 2006 04:09:39 +0000
Message-Id: <1165723779.334.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 09:38 -0500, Daniel Drake wrote:
> Adrian Bunk wrote:
> > Daniel Drake (1):
> >       PCI: VIA IRQ quirk behaviour change
> 
> Please drop this one, Alan isn't 100% on it and is working on getting a 
> better fix into mainline
> 
> Daniel

Sorry Daniel, I don't agree with you, this patch is a improvement of the
original patch and in my opinion should go in.
As Alan explain to us, is not the prefect one, but still be an
improvement.

Thanks,
--
Sérgio M. B. 

