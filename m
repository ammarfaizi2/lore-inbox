Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031626AbWLAAJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031626AbWLAAJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031625AbWLAAJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:09:48 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:35931 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1031620AbWLAAJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:09:47 -0500
Date: Thu, 30 Nov 2006 18:07:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
In-reply-to: <200611301746.27193.prakash@punnoor.de>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Allen Martin <AMartin@nvidia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       jeff@garzik.org
Message-id: <456F7234.8010203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <DBFABB80F7FD3143A911F9E6CFD477B018E81719@hqemmail02.nvidia.com>
 <200611301746.27193.prakash@punnoor.de>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Am Dienstag 10 Oktober 2006 08:44 schrieb Allen Martin:
> 
>> No, only CK804 and MCP04 support ADMA.  We'll be publishing some patches
>> for NCQ support for MCP55/MCP61 soon.
> 
> Just wondering whether I missed them? It is now 1,5 month later...

I don't think you missed them.. It would be nice to get this support in, 
those are the last NVIDIA chipsets which have NCQ support (apparently) 
that don't support it under Linux. Even just the hardware docs would be 
useful..

---
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
