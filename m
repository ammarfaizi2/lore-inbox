Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbTGXRwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269650AbTGXRwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:52:24 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:12280 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269639AbTGXRwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:52:23 -0400
Message-ID: <3F201F1A.2010506@rackable.com>
Date: Thu, 24 Jul 2003 11:02:02 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Bas Mevissen <ml@basmevissen.nl>, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>	<1059058737.7994.25.camel@dhcp22.swansea.linux.org.uk>	<3F1FFC94.7080409@basmevissen.nl> <20030724193211.39d7ed68.diegocg@teleline.es>
In-Reply-To: <20030724193211.39d7ed68.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jul 2003 18:07:28.0892 (UTC) FILETIME=[71CF0BC0:01C3520E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:

>El Thu, 24 Jul 2003 17:34:44 +0200 Bas Mevissen <ml@basmevissen.nl> escribió:
>
>  
>
>>This would make a reasonable Q-requirement for 2.6.0 that at least the 
>>kernel compiles with 'make allyesconfig'. The only thing open is to 
>>    
>>
>
>That 2.6.0 builds with 'make allyesconfig' or not is irrelevant.
>Moving broken drivers to a dark place doesn't fix them  nor increase the
>"quality" level.....
>  
>

  It certainly improves perceived quality level.  People new to linux 
are going to think 2.6 is a pile of crap that will not compile.  Not to 
mention it reduces the possible things that can trip up a new

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


