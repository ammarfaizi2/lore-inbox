Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWECEQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWECEQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 00:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWECEQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 00:16:03 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19799 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965084AbWECEQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 00:16:01 -0400
Date: Tue, 02 May 2006 22:15:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.17-rc3 "Bus #03 (-#06) is hidden behind transparent bridge"
In-reply-to: <200605030508.07526.s0348365@sms.ed.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <44582E67.6020300@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <4458284F.9070604@shaw.ca>
 <200605030508.07526.s0348365@sms.ed.ac.uk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> A lot of people seem to be seeing this, but Linux magically sorts it out. I 
> get it on my nForce4/Athlon64 X2 system and my NC6000 855PM/P-M laptop..
> 
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #05 (-#08) is hidden behind transparent bridge #02 (-#05) (try 
> 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> 
> Not too dissimilar.. maybe this warning should be removed?
> 

The message advising to report to LKML was only added since 2.6.16 
though.. I assume somebody must have wanted to be notified :-)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
