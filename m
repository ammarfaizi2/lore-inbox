Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWA2Xm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWA2Xm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWA2Xm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:42:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36550 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932086AbWA2Xm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:42:26 -0500
Date: Sun, 29 Jan 2006 18:42:13 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy edac
Message-ID: <20060129234213.GA20133@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060127014105.GD16422@redhat.com> <20060129215206.GA18670@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129215206.GA18670@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 04:52:06PM -0500, Alan Cox wrote:
 > On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
 > > e752x_edac is very noisy on my PCIE system..
 > > my dmesg is filled with these...
 > > 
 > > [91671.488379] Non-Fatal Error PCI Express B
 > > [91671.492468] Non-Fatal Error PCI Express B
 > > [91901.100576] Non-Fatal Error PCI Express B
 > > [91901.104675] Non-Fatal Error PCI Express B
 > 
 > Pre-production system or final release ?

Currently shipping Dell Precision 470.

		Dave

