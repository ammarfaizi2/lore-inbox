Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWHPC66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWHPC66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWHPC66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:58:58 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:30602 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750852AbWHPC65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:58:57 -0400
Date: Tue, 15 Aug 2006 20:57:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc4-mm1
In-reply-to: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <44E28989.1010904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/

Warnings and an oops on suspend to disk:

http://www.roberthancock.com/oops1.jpg
http://www.roberthancock.com/oops2.jpg
http://www.roberthancock.com/oops3.jpg
http://www.roberthancock.com/oops4.jpg
http://www.roberthancock.com/oops5.jpg
http://www.roberthancock.com/oops6.jpg
http://www.roberthancock.com/oops7.jpg
http://www.roberthancock.com/oops8.jpg

Sleeping function called from invalid context in acpi and kernel NULL 
pointer dereference in _raw_spin_lock from generic_unplug_device, with 
some "DWARF2 unwinder stuck" errors for good measure..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

