Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUBWTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUBWTj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:39:56 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:16545 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262008AbUBWTjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:39:55 -0500
Date: Mon, 23 Feb 2004 12:42:34 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Mark Rutherford <mark@justirc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 + linux 2.6.3-rc2 + acpi,apic patches
Message-ID: <20040223194234.GA755@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Mark Rutherford <mark@justirc.net>, linux-kernel@vger.kernel.org
References: <20040211012912.GA948@tesore.local> <200402221242.47581.mark@justirc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402221242.47581.mark@justirc.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 12:42:47PM -0500, Mark Rutherford wrote:
> Jesse,
> 
> I saw this thread on the mailing list about your sucess with the nforce2...
> I havent had much sucess with it, and was wondering if you have tried -rc3

I have tried -rc3.  But I am now using vanilla 2.6.3.

> Also, do you know if Andrew Morton's patches are cumulative?
> would he have these patches in rc3-mm2 ?

probably.  Unless it is decided a patch is bad. Generally, they stay until 
something is determined so people will test it more.

> 
> I have been using my nforce2 machine in XT-PIC ... and its pretty bad.
> I have some hardware that doesnt want to share the irq so it gets dicey.
> I would like to get it fixed, I have posted, but I didnt get a response.
> 

What happens in APIC?

Jesse
