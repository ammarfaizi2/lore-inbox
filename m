Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTLEMJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTLEMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:09:19 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:53141 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263946AbTLEMJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:09:17 -0500
Message-ID: <3FD07611.4050709@stesmi.com>
Date: Fri, 05 Dec 2003 13:12:01 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
References: <YPep.5Y5.21@gated-at.bofh.it> <Z3AK-Qw-13@gated-at.bofh.it> <3FCF696F.4000605@softhome.net> <3FD067CF.4010207@aitel.hist.no>
In-Reply-To: <3FD067CF.4010207@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Ihar 'Philips' Filipau wrote:
> 
>>   GPL is about distribution.
>>
>>   e.g. NVidia can distribute .o file (with whatever license they have 
>> to) and nvidia.{c,h} files (even under GPL license).
>>   Then install.sh may do on behalf of user "gcc nvidia.c blob.o -o 
>> nvidia.ko". Resulting module are not going to be distributed - it is 
>> already at hand of end-user. So no violation of GPL whatsoever.
> 
> 
> Open source still win if they do this.  Anybody interested
> may then read the restricted source and find out how
> the chip works.  They may then write an open driver
> from scratch, using the knowledge.

What I think he means is that nvidia.c only contains glue code and
blob.o contains the secret parts just like the current driver from
nvidia.

// Stefan

