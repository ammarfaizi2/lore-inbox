Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbULBVOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbULBVOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbULBVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:12:21 -0500
Received: from levante.wiggy.net ([195.85.225.139]:35295 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261773AbULBVI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:08:59 -0500
Date: Thu, 2 Dec 2004 22:08:55 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041202210855.GA30914@wiggy.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com> <20041202204838.04f33a8c.diegocg@gmail.com> <41AF7726.4000509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AF7726.4000509@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jeff Garzik wrote:
> Should be simple for rpm at least, given the "make rpm" target.  I 
> wonder if we have, or could add, a 'make deb' target.

make deb-pkg has been there for a while.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
