Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUG0UU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUG0UU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266597AbUG0UUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:20:21 -0400
Received: from havoc.gtf.org ([216.162.42.101]:63399 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266590AbUG0UUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:20:11 -0400
Date: Tue, 27 Jul 2004 16:20:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Doug Maxey <dwm@austin.ibm.com>,
       Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Message-ID: <20040727202010.GA2280@havoc.gtf.org>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com> <41067543.3090003@pobox.com> <4106C5B7.9040606@clanhk.org> <20040727201557.GA1612@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727201557.GA1612@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 04:15:57PM -0400, Jeff Garzik wrote:
> That refers to SATA devices, not controllers.

Or in other words, libata supports PCI bus hotplug (controller<->system
hotplug), but not SATA bus hotplug (device<->controller hotplug).

	Jeff



