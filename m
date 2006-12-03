Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754075AbWLCPwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbWLCPwe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbWLCPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:52:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31557 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1753329AbWLCPwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:52:31 -0500
Date: Sun, 03 Dec 2006 09:52:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata update?
In-reply-to: <fa.UAIxHHsfQPfRUPTHLywDGPoXEbE@ifi.uio.no>
To: erik@echohome.org
Cc: linux-kernel@vger.kernel.org
Message-id: <4572F2B9.7090306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.UAIxHHsfQPfRUPTHLywDGPoXEbE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Ohrnberger wrote:
> It's been a number of months since I build a custom kernel with the libata
> incorporated to deal with multiple Promise EIDE controller card's 'DMA
> Expiry' errors.
> 
> I'd like to re-build basically the same thing with an updated kernel and
> updates libata.  Could someone point me into the right direction to achieve
> this?
> 
> Thanks in advance
> Erik.

All of the PATA stuff was merged in 2.6.19, if you want the very latest 
and greatest you can try the -mm tree..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

