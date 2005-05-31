Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVEaAF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVEaAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVEaADt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:03:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52519 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261839AbVEaACM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:02:12 -0400
Date: Mon, 30 May 2005 18:00:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] SATA NCQ support
In-reply-to: <48Pzt-6Kb-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <429BA937.2090802@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <48Hix-88s-7@gated-at.bofh.it> <48N4N-4B5-25@gated-at.bofh.it>
 <48Pzt-6Kb-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Matthias Andree wrote:
> 
>> OK, so this is for AHCI. What are the options for people whose
>> mainboards aren't blessed with AHCI, but use for instance VIA or older
>> Promise chips? Buy new hardware? Or wait until someone comes up with an
>> implementation?
> 
> 
> As Jens mentioned, NCQ support requires both device and hardware have 
> explicit NCQ support.  That eliminates most of Linux's supported SATA 
> controllers, none of which support NCQ.
> 
> Don't have a heart attack, though, SATA is pretty fast even without NCQ.
> 

NVIDIA nForce4 supports NCQ under Windows.. any word on whether docs may 
become available to allow this to be supported under Linux? You'd think 
NVIDIA would want to get that support in..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

