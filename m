Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCPVJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCPVJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:09:06 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:3200 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261678AbUCPVI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:08:59 -0500
Date: Tue, 16 Mar 2004 21:09:14 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: SCSI emulation interface description
Message-ID: <20040316210914.B606@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I would like to know, if I switch on "SCSI emulation" in my
2.4.25 kernel,
1) Will some kind of interface be added to my kernel?
2) If yes, where is this interface specified?

Bugreport:
"man bootparam" mentioned in help for SCSI emulation option doesn't work
on all systems (at least my LFS)

"see documentation of your boot loader for how to pass options
to your kernel":
1) proper place for kernel commandline option specification is not boot loader
doc but kernel doc
2) where is the "linux kernel boot time parameter interface" specified?

Cl<
