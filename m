Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbULFP4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbULFP4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbULFP4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:56:10 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:32384
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261544AbULFPyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:54:35 -0500
Date: Mon, 6 Dec 2004 07:54:34 -0800
From: Phil Oester <kernel@linuxace.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidea Graphics card not recognised by lspci
Message-ID: <20041206155434.GA20693@linuxace.com>
References: <kiiZIHd0T0000153f@hotmail.com> <20041206121608.585d7526@phoebee> <200412061429.05910.andrew@walrond.org> <200412061040.50015.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412061040.50015.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:40:49AM -0500, Gene Heskett wrote:
> On Monday 06 December 2004 09:29, Andrew Walrond wrote:
> 
> >update-pciids
> bash: update-pciids: command not found
> 
> System is FC2, kernel 2.6.10-rc3
> lspci version 2.1.99-test3
> 
> Do I need to grab a newer util package that contains lspci?

Simply replace /usr/share/hwdata/pci.ids with a newer version
from http://pciids.sourceforge.net/.

Phil
