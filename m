Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWIVJxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWIVJxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIVJxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:53:04 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:32412 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750857AbWIVJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:53:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=z+aCJGF6gHH2AdoeXRhnaTnrXwx12YQmP2Z9RgF1bU+vMGCigZA5vyj5CqmkVekyf6duwDint27vTbn3TOrNT3wkJMvvF8hh6GAyn45up9DsjWh5UeQmbYMhBgIGcO7x0lpWfQsyhlG4H+ggRUkGObq7LIt+wCP1B33RaITF0xk=  ;
Message-ID: <4513B27B.5040602@yahoo.com.au>
Date: Fri, 22 Sep 2006 19:52:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: akpm@osdl.org, mingo@elte.hu, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] sched: introduce child field in sched_domain
References: <20060921143924.A25601@unix-os.sc.intel.com>
In-Reply-To: <20060921143924.A25601@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Andrew,
> 
> Please drop sched-generic-sched_group-cpu-power-setup.patch in your
> -mm tree and add these two split up patches instead.
> 
> First patch appended and second patch will follow this.

Thanks Suresh. These are both
Acked-by: Nick Piggin <npiggin@suse.de>

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
