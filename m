Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULMXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULMXhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULMXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:37:23 -0500
Received: from [128.8.126.38] ([128.8.126.38]:36108 "EHLO www.missl.cs.umd.edu")
	by vger.kernel.org with ESMTP id S261345AbULMXhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:37:06 -0500
Date: Mon, 13 Dec 2004 18:55:49 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Juergen Botz <jurgen@botz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad T42, keyboard sometimes hosed when waking from sleep
In-Reply-To: <cpl6n2$ivd$1@sea.gmane.org>
Message-ID: <Pine.BSF.4.61.0412131854030.66694@www.missl.cs.umd.edu>
References: <cpl6n2$ivd$1@sea.gmane.org>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Dec 2004, Juergen Botz wrote:

> I have a new IBM Thinkpad T42, FC3 with all updates, stock
> 2.6.9-1.681_FC3 kernel + iwp2200 driver (0.13).  Everyone once
> in a while when I wake from ACPI S3 sleep my keyboard is hosed...
> the first key I press starts rapidly auto-repeating, which can't
> be stopped, and pressing any key produces either no visible
> action or some other character (not the one normally on that
> key) which also auto repeats madly.
>
> It doesn't always happen, only maybe 10% of the time I come
> out of S3.  I can't switch to different vt since ctrl-alt-fN
> don't work, and since I am rarely on a text console I have
> no idea whether it would happen there.  Putting the machine
> back to sleep and re-waking doesn't fix it, so my only option
> has been to reboot via the 'Actions' menu (mouse is ok through
> all this.)
>
> Others have also reported this happening with APM, so it
> doesn't seem to be an ACPI bug per se.
>
> Any ideas?

just another data point. I had seen the same thing happen for me once with 
my T41p. Same config as above ie FC3, 2.6.9-1.681_FC3.

might be some RH-FC specific thing since I did not see it happen with 
earlier incarnations of kernel.

