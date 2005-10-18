Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVJRWGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVJRWGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJRWGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:06:36 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3589 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932167AbVJRWGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:06:35 -0400
Message-ID: <43557201.1070902@tmr.com>
Date: Tue, 18 Oct 2005 18:06:57 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Derbey Nadia <Nadia.Derbey@bull.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] - AKT project
References: <43535245.9070807@bull.net>
In-Reply-To: <43535245.9070807@bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derbey Nadia wrote:
> I'm announcing last version of the libtune API, that has been developped 
> to unify the way developers have to access Linux kernel tunables, system 
> information, resource consumptions.
> 
> User documentation can be found at http://akt.sf.net/doc/aktapi.doc.01.html
> 
> Design documentation can be found at 
> http://akt.sf.net/doc/aktapi.design.07.html
> 
> The sources can be downloaded from
> http://sourceforge.net/project/showfiles.php?group_id=136028
> 
> Next step of the project will consist in making the kernel able to tune 
> the resources as it sees appropriate.

The reason for having tunables is so the admin can get the behaviour 
desired. Since the kernel can't really know which behaviour to optimize 
this would wind up being the kernel tuning itself to your (someone's) 
idea of better. That may be great for some newbie, but honestly the 
default values put in by the developers are satisfactory in most cases.

I hope "as it sees appropriate" isn't really what you mean...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
