Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTLELA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTLELA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:00:27 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:34317 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263918AbTLELAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:00:20 -0500
Message-ID: <3FD067CF.4010207@aitel.hist.no>
Date: Fri, 05 Dec 2003 12:11:11 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Jason Kingsland <Jason_Kingsland@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
References: <YPep.5Y5.21@gated-at.bofh.it> <Z3AK-Qw-13@gated-at.bofh.it> <3FCF696F.4000605@softhome.net>
In-Reply-To: <3FCF696F.4000605@softhome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:

>   GPL is about distribution.
> 
>   e.g. NVidia can distribute .o file (with whatever license they have 
> to) and nvidia.{c,h} files (even under GPL license).
>   Then install.sh may do on behalf of user "gcc nvidia.c blob.o -o 
> nvidia.ko". Resulting module are not going to be distributed - it is 
> already at hand of end-user. So no violation of GPL whatsoever.

Open source still win if they do this.  Anybody interested
may then read the restricted source and find out how
the chip works.  They may then write an open driver
from scratch, using the knowledge.

Helge Hafting

