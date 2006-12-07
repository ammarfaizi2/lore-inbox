Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937962AbWLGOi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937962AbWLGOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937959AbWLGOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:38:56 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:46778 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937962AbWLGOiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:38:55 -0500
Message-ID: <45782774.8060002@gentoo.org>
Date: Thu, 07 Dec 2006 09:38:44 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
References: <20061207132430.GF8963@stusta.de>
In-Reply-To: <20061207132430.GF8963@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Daniel Drake (1):
>       PCI: VIA IRQ quirk behaviour change

Please drop this one, Alan isn't 100% on it and is working on getting a 
better fix into mainline

Daniel

