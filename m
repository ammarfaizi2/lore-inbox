Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWAYOru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWAYOru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWAYOru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:47:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44332 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751183AbWAYOrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:47:49 -0500
Date: Wed, 25 Jan 2006 08:43:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Patch for CVE-2004-1334 ???
In-reply-to: <5yOFI-5CN-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43D78E9C.1000804@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5ydZz-2G1-7@gated-at.bofh.it> <5yetg-3us-31@gated-at.bofh.it>
 <5yOFI-5CN-19@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Syed Ahemed wrote:
> The simple reason we do not intend to use the latest version is we run
> some third party software which cant be front ported (pardon the slang
> ) to 2.4.29 and above.
> As for the changeset by  guninski , i wish to ask about a one point
> source of applying all the patches for 2.4.28 .I mean shouldn't all
> the kernel security patches ( atleast the ones that have become CVE's)
> be a part of kernel.org .Since there isn't any what is the reason ?

It is "part of kernel.org", it's called 2.4.32. The kernel developers 
can hardly be expected to release a patch for every vulnerability 
against every possible kernel version ever released..

If you need guaranteed security patches against a specific version of 
the kernel you should likely be using a distribution kernel and not a 
vanilla kernel.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

