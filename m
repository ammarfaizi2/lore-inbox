Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULZVCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULZVCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULZVCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 16:02:23 -0500
Received: from mx.inch.com ([216.223.198.27]:62224 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261165AbULZVCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 16:02:20 -0500
Date: Sun, 26 Dec 2004 16:02:17 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
In-Reply-To: <1104082455.15992.13.camel@localhost.localdomain>
Message-ID: <20041226160054.D41723@shell.inch.com>
References: <20041225193400.GA2700@localhost.localdomain> 
 <1104005852.23660.0.camel@localhost.localdomain>  <20041226000321.W98794@shell.inch.com>
 <1104082455.15992.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Alan Cox wrote:

> On Sul, 2004-12-26 at 05:09, John McGowan wrote:
>> To which version? 6.8.1 (rpm build from Fedora Core xorg-6.8.1-12.src.rpm).
>> I see that 6.8.1 is the latest at xorg.
>
> Right but there are patches in CVS beyond that and some are merged into
> the FC testing/rawhide packages
>
>> Fixed the memory or getting X to run at all on an 810?
>
> I have 2D running nicely but not 3D

The fedora core 3 development branch has a source rpm which I built in
core 2. I am now using kernel 2.6.10 (still problems with gimp-gap
chewing up memory which isn't freed). Thanks for your time. Now I will
have to see if there is something newer at xorg.
