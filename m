Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWEZKYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWEZKYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWEZKYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:24:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:54216 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751374AbWEZKYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:24:03 -0400
Message-ID: <4476D73E.6060508@garzik.org>
Date: Fri, 26 May 2006 06:23:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de, trenn@suse.de,
       joachim deguara <joachim.deguara@amd.com>
Subject: Re: Recent x86-64 patch causes many devices to disappear
References: <4476D020.8070605@garzik.org> <200605261203.55108.ak@suse.de>
In-Reply-To: <200605261203.55108.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 26 May 2006 11:53, Jeff Garzik wrote:
>> *.rc4		- rc4, plus some libata changes, PCI domains disabled
>> *.rc5		- rc5-git1, PCI domains disabled
>> *.rc5-pcidom	- rc5-git1, PCI domains enabled

> Do you have PCI segmentation disabled in your BIOS? 

The strings "PCI domains disabled" and "PCI domains enabled" indicate 
the state of the BIOS setting, at the time the dumps were taken.

	Jeff



