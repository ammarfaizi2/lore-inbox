Return-Path: <linux-kernel-owner+w=401wt.eu-S932077AbXAFTB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbXAFTB7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbXAFTB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:01:59 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31648 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbXAFTB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:01:59 -0500
Date: Sat, 06 Jan 2007 13:01:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata error handling
In-reply-to: <1168109874.1512.11.camel@localhost>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
Message-id: <459FF1F8.1050306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
 <459FE8BE.7070208@shaw.ca> <1168109874.1512.11.camel@localhost>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
> On Sat, 2007-01-06 at 12:21 -0600, Robert Hancock wrote:
>> Kasper Sandberg wrote:
>>> i have heard that libata has much better error handling (this is what
>>> made me try it), and from initial observations, that appears to be very
>>> true, however, im wondering, is there something i can do to get
>>> extremely verbose information from libata? for example if it corrects
>>> errors? cause i'd really like to know if it still happens, and if i
>>> perhaps get corruption as before, even though not severe.
>> Any errors, timeouts or retries would be showing up in dmesg..
> how sure can i be of this? is it 100% sure that i have not encountered
> this error then?

Pretty sure, I'm quite certain libata never does any silent error recovery..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/



