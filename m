Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWBUXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWBUXsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBUXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:48:12 -0500
Received: from rtr.ca ([64.26.128.89]:45484 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030211AbWBUXsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:48:09 -0500
Message-ID: <43FBA6AF.3070207@rtr.ca>
Date: Tue, 21 Feb 2006 18:47:59 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc[34]: resume-from-RAM unreliable
References: <43F9D3CA.1010709@rtr.ca> <20060220210943.7f159749.akpm@osdl.org>
In-Reply-To: <20060220210943.7f159749.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
>> For the past week, I've been trying to keep with the latest -rc*-git*
>> releases of 2.6.16 on my notebook, and something new in those is
>> impacting resume-from-RAM.

Mmm.. working 100% now with Randy Dunlop's ACPI additions from here:

     http://www.xenotime.net/linux/SATA/2.6.16-rc3/

Note that these are the latest evolution from a simpler patch by Jens
which I first started using in *spring 2005* to get suspend/resume working.

Are we *ever* going to add these to mainstream?
It's been almost a friggin' year!

Cheers

