Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWBXOFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWBXOFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWBXOFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:05:31 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:63939 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750881AbWBXOFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:05:31 -0500
Date: Fri, 24 Feb 2006 07:05:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: aziro aziroff <aziro.linux.adm@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [JNI FCE-3210-C 32-bit PCI-to-Fibre Channel HBA]Driver for linux kernel 2.4 and/or 2.6?
Message-ID: <20060224140526.GM28587@parisc-linux.org>
References: <f30adcc00602240157w7104c598qe7fffa2dcbee6105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30adcc00602240157w7104c598qe7fffa2dcbee6105@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 11:57:45AM +0200, aziro aziroff wrote:
> I looking for linux driver for one old JNI Fibre Channel (FC) host bus adapter
> model: FCE-3210 "32-bit" PCI-to-Fibre Channel HBA (1999/2000).
> I ask google and nothing about driver donload link, just comment and
> broken links:)
> http://www.exquip.com/products/storage/hostbusadapters.php?view=250
> 
> I read that Red Hat Linux 6.0, 6.1 support JNI FCE-3210, but no
> information about kernels 2.4 and 2.6?!

You're out of luck; it seems JNI never published source code, only a
binary module for ancient versions of Red Hat.  I suggest you get a
Qlogic, Emulex or LSI FC card instead as all three drivers are actively
supported by their respective hardware vendor.
