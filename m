Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946598AbWJSWhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946598AbWJSWhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946600AbWJSWhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:37:19 -0400
Received: from commie.imr-net.com ([65.182.241.242]:28905 "EHLO
	commie.imr-net.com") by vger.kernel.org with ESMTP id S1946598AbWJSWhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:37:18 -0400
Message-ID: <4537FE1C.2060508@imr-net.com>
Date: Thu, 19 Oct 2006 15:37:16 -0700
From: Joshua Schmidlkofer <joshua@imrlive.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Joshua Schmidlkofer <jms@dev.imr-net.com>, linux-kernel@vger.kernel.org,
       Mike Montagne <mike@opsisarch.com>
Subject: Re: Recurring MegaRAID SCSI Errors
References: <4537F7AA.4060709@imr-net.com> <20061019222633.GC7410@lists.us.dell.com>
In-Reply-To: <20061019222633.GC7410@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Most likely you need this patch:
> http://marc.theaimsgroup.com/?l=linux-scsi&m=115992186113515&w=2
>
> Thanks,
> Matt
>
>   


Matt,


 Thanks for the reply.  Will this patch affect the non-SAS controllers?  
My PERC4/DC is SCSI and not SAS.


Sincerely,
 Joshua

