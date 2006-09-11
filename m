Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWIKVSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWIKVSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWIKVSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:18:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:26069 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965050AbWIKVSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:18:33 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: io-apic - no timer ticks after resume on IXP200
Date: Mon, 11 Sep 2006 22:02:50 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060910141533.GA6594@srcf.ucam.org> <200609110746.58548.ak@suse.de> <20060911110530.GA15320@srcf.ucam.org>
In-Reply-To: <20060911110530.GA15320@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112202.50756.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 13:05, Matthew Garrett wrote:
> On Mon, Sep 11, 2006 at 07:46:58AM +0200, Andi Kleen wrote:
> > You forgot to mention on which kernel version you're seeing this?
> > In particular did it work in some kernel version and then stop in
> > another?
>
> Oops, sorry. I'm using 2.6.17.11, but the problem appears to persist in
> the latest 2.6.18-rc. 

And did it work with a earlier kernel?

-Andi

