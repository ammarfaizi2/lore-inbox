Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCAA4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCAA4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCAAyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:54:12 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15507 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261157AbVCAAxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:53:16 -0500
Date: Mon, 28 Feb 2005 18:52:17 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Fw: 2.6.11-rc4 doubles CPU temperature
In-reply-to: <3D15Y-7Ju-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4223BCC1.10608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3D15Y-7Ju-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Castricum wrote:
> 
> For some weird reason, 2.6.11-rc4 up to the current BK tree about 
> doubles my
> CPU temperature from 20 degrees Celcius to 40 while everything else is
> unchanged (load/processes/config). The system does seem a bit more 
> sluggish,
> but that may just be a feeling. A cat /proc/cpu gives me
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Celeron (Mendocino)
> stepping        : 5
> cpu MHz         : 475.100

How are you determining this temperature? 20 degrees seems pretty 
unlikely for any CPU, let alone a Mendocino Celeron - 40 degrees is more 
reasonable..

