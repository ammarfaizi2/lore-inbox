Return-Path: <linux-kernel-owner+w=401wt.eu-S965004AbWL1Vxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWL1Vxs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWL1Vxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:53:48 -0500
Received: from [139.30.44.16] ([139.30.44.16]:20333 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964991AbWL1Vxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:53:47 -0500
Date: Thu, 28 Dec 2006 22:53:44 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Randy Dunlap <randy.dunlap@oracle.com>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228214830.GF20596@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0612282251560.6944@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
 <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
 <20061228213438.GD20596@flint.arm.linux.org.uk> <20061228133246.ad820c6a.randy.dunlap@oracle.com>
 <20061228214830.GF20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Russell King wrote:

> Given that it takes about 8 to 12 hours to do a build cycle, that's

My build cycle takes about 2 hours for 4 configs, on a decent AMD64 
system (running completely in tmpfs). Am I doing something wrong or are 
you talking about native builds?

Tim
