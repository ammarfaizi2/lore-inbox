Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTFYXti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbTFYXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:49:37 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:61487 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265144AbTFYXte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:49:34 -0400
Message-ID: <3EFA3770.70806@rackable.com>
Date: Wed, 25 Jun 2003 16:59:44 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Jackson <brian@brianandsara.net>
CC: Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
Subject: Re: Is their an explanation of various kernel versions/brances/patches/?
 (-mm, -ck, ..)
References: <bdd64m$3dr$1@main.gmane.org> <200306251857.48341.brian@brianandsara.net>
In-Reply-To: <200306251857.48341.brian@brianandsara.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Jun 2003 00:03:45.0441 (UTC) FILETIME=[693ED110:01C33B76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Jackson wrote:

>I don't know of a website that tracks that stuff, but here goes my knowledge 
>of the different patchsets:
>
>for the most part all of them are testing grounds for patches that someday 
>hope to be in the vanilla kernel
>
>mm - Andrew Morton - vm related testing ground for dev tree
>ck - Con Kolivas - desktop/interactivity patches
>kj - Kernel Janitors - testing ground for kernel cleanups on development trees
>mjb - Martin J Bligh - scalability stuff
>wli - William Lee Irwin - other vm related stuff for dev tree that Andrew
>	Morton may not have time for
>ac - Alan Cox - lately it's been a testing ground for new ide
>
  Actually the ac is often the test ground for new 2.4 fixes, and features.

>lsm - Chris Wright - Linux Security Modules, provides a lightweight, general
>	purpose framework for access control
>osdl - Stephen Hemminger, ? maybe enterprise stuff
>laptop - Hanno Böck - unproven laptop type patches
>aa - Andrea Arcangeli - stable series vm stuff
>dj - Dave Jones - cleanups/AGP
>rmap - Rik van Riel - reverse mapping vm for 2.4
>pgcl - William Lee Irwin - ?
>
>Others? Oh yes. Maybe this is something that should be tracked on a webpage 
>somewhere.
>
>--Brian Jackson
>
>On Wednesday 25 June 2003 05:02 pm, Orion Poplawski wrote:
>  
>
>>Seems like everybody and their brother is maintaining a kernel patch set
>>these days :-).
>>
>>Is there a page somewhere that explains the goals of each of the various
>>versions?
>>
>>Thanks!
>>
>>- Orion
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


