Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272158AbTHDStS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272161AbTHDStS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:49:18 -0400
Received: from rj.sgi.com ([192.82.208.96]:54176 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S272158AbTHDStQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:49:16 -0400
Date: Mon, 4 Aug 2003 11:49:13 -0700
To: davidm@hpl.hp.com
Cc: "H. J. Lu" <hjl@lucon.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-ID: <20030804184913.GA501@sgi.com>
Mail-Followup-To: davidm@hpl.hp.com, "H. J. Lu" <hjl@lucon.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com> <20030804175308.GB16804@lucon.org> <20030804180015.GA543@sgi.com> <16174.42409.306836.375697@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16174.42409.306836.375697@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:27:53AM -0700, David Mosberger wrote:
> >>>>> On Mon, 4 Aug 2003 11:00:16 -0700, jbarnes@sgi.com (Jesse Barnes) said:
> 
>   Jesse> big sur is broken because non-ACPI based PCI enumeration has
>   Jesse> been removed from the tree.
> 
> That shouldn't break big sur.  Perhaps you need newer firmware,
> though?

You're right, I thought that big sur didn't use ACPI to enumerate PCI,
but I guess it does.

Jesse
