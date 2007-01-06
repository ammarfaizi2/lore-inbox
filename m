Return-Path: <linux-kernel-owner+w=401wt.eu-S1751433AbXAFSV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXAFSV6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXAFSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:21:58 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:10647 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbXAFSV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:21:57 -0500
Date: Sat, 06 Jan 2007 12:21:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata error handling
In-reply-to: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
Message-id: <459FE8BE.7070208@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.pdj7pJD9C08bRZatFINV1hz1oyA@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
> i have heard that libata has much better error handling (this is what
> made me try it), and from initial observations, that appears to be very
> true, however, im wondering, is there something i can do to get
> extremely verbose information from libata? for example if it corrects
> errors? cause i'd really like to know if it still happens, and if i
> perhaps get corruption as before, even though not severe.

Any errors, timeouts or retries would be showing up in dmesg..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

