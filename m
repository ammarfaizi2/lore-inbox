Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbTGLNfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbTGLNfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:35:50 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26385 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265639AbTGLNfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:35:44 -0400
Date: Sat, 12 Jul 2003 15:50:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: AMD 53C974 based SCSI adapter (was: Linux 2.5.75)
Message-ID: <20030712135024.GC1902@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Linus Torvalds wrote:

> Ok. This is it. We (Andrew and me) are going to start a "pre-2.6" series,
> where getting patches in is going to be a lot harder. This is the last
> 2.5.x kernel, so take note.

The AMD PCscsiII chip, commonly referred to as AM53C974, and supported
in 2.4 by two drivers, am53c974 and tmscsim, still isn't working with
2.5.75, neither driver compiles (built-in). (This is on akpm's must-fix v6.)
