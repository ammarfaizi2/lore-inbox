Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVKVATk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVKVATk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVKVATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:19:40 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6305 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964781AbVKVATi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:19:38 -0500
Date: Mon, 21 Nov 2005 18:19:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.14.2 detects only one processor (out of 2)
In-reply-to: <5bsEh-4Sc-51@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43826414.4060701@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5bpni-8r0-5@gated-at.bofh.it> <5bsEh-4Sc-51@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Pegon wrote:
> Hi,
> 
> try with acpi enabled, it works for me. It's seem that recent kernel 
> (since 2.6.12) need acpi for SMP.

It should not - if it does this is a bug, as SMP motherboards that do 
not support ACPI will not work.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

