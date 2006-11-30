Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759013AbWK3Egt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013AbWK3Egt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759024AbWK3Egt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:36:49 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7467 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1759013AbWK3Egs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:36:48 -0500
Date: Wed, 29 Nov 2006 22:35:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: mass-storage problems with Archos AV500
In-reply-to: <fa.+HViQkzstd1WGzxw6QnaK2a1tiY@ifi.uio.no>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tao@acc.umu.se
Message-id: <456E5F91.7020300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.+HViQkzstd1WGzxw6QnaK2a1tiY@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> I've got an Archos AV500 here (running the very latest firmware), pretty
> much acting as a doorstop, since I cannot get it to be recognized
> properly by Linux.

..

> [  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
> MB)
> [  118.144000] sdb: Write Protect is off
> [  118.144000] sdb: Mode Sense: 33 00 00 00
> [  118.144000] sdb: assuming drive cache: write through
> [  118.144000]  sdb: unknown partition table
> [  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb
> [  118.452000] usb-storage: device scan complete
> 
> This is with linux-image-2.6.19-7-generic 2.6.19-7.10 from Ubuntu edgy.
> I get similar results with a home-brew 2.6.18-rc4.
> 
> Any mass storage quirk needed that might be missing?

That all seems normal, other than the unknown partition table, but the 
device might be all one unpartitioned disk.. at what point is it failing?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

