Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVLPTOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVLPTOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVLPTOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:14:00 -0500
Received: from mexforward.lss.emc.com ([168.159.213.200]:58034 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932387AbVLPTN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:13:59 -0500
Message-ID: <43A2E797.9000604@emc.com>
Date: Fri, 16 Dec 2005 11:13:11 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: akpm@osdl.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
       "saparnis, carol" <saparnis_carol@emc.com>
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
References: <20051216143348.GB19541@lst.de> <1134745099.5495.31.camel@localhost.localdomain> <20051216150058.GA20144@lst.de> <1134750741.5495.40.camel@localhost.localdomain> <20051216163825.GA21977@lst.de>
In-Reply-To: <20051216163825.GA21977@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.12.16.21
X-PerlMx-Spam: Gauge=, SPAM=0%, Reasons='EMC_BODY_1+ -5, EMC_FROM_00+ -3, DATE_IN_PAST_03_06! 1.0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>Ok understood, but at least I have warn the EMC people about that change
>>so that they can send a patch for the dasd driver ..
> 
> 
> Sure, at this patch is a 2.6.16 thing, which is more than enough time
> for them.  I'm happy to review any code they submit for kernel
> inclusion.
> 


Hi Martin,

I am going to work with Carol (cc'ed below) to put out the module code 
that we have under GPL.  We need to run it through our EMC (relatively 
newish) open source process to get official permission, but I don't 
expect any big hurdles.

Are you the right person for Carol to work with on the code structure, 
style, etc once we get the green light to move forward?

Regards,

ric


