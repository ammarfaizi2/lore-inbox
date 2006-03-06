Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWCFVKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWCFVKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbWCFVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:10:09 -0500
Received: from brmea-mail-1.Sun.COM ([192.18.98.31]:63215 "EHLO
	brmea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S1752435AbWCFVKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:10:07 -0500
Date: Mon, 06 Mar 2006 13:09:52 -0800
From: Michael Bender <Michael.Bender@Sun.COM>
Subject: Re: [Libusb-devel] Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL
 / USB drivers of major vendor excluded
In-reply-to: <20060306170542.GB8142@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: s.schmidt@avm.de, kkeil@suse.de, libusb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       opensuse-factory@opensuse.org, torvalds@osdl.org
Reply-to: Michael.Bender@Sun.COM
Message-id: <440CA520.8070507@sun.com>
Organization: Sun Microsystems, Inc.
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <20060217230004.GA15492@kroah.com>
 <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
 <20060306170542.GB8142@kroah.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Mar 06, 2006 at 01:47:43PM +0100, s.schmidt@avm.de wrote:
>
>>Compared to other operating systems, such as Mac OS, BeOS,
>>Windows etc., Linux is walking a solitary path with the "user mode only"
>>shift. One gets the impression, that legal concerns are leading Linux to a
>>technically suboptimal/isolated solution.
>
> No, right now, Linux has the best latency numbers _by far_ than any
> other operating system, so we can move stuff to userspace.
> 
> And again, it's your legal issues that are forcing you that way, if you
> change that, putting everything in the kernel would be fine :)

(Since this came to me via the libusb list, and we've kind of
gone past libusb-specific-related discussion, I thought I'd
add another question to the thread).

What's the rationale behind the dichotomy between userspace
and kernel licensing models?

mike
