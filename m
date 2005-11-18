Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVKRECf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVKRECf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKRECe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:02:34 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:24299 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932476AbVKRECc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:02:32 -0500
Message-ID: <437D51BA.60608@mvista.com>
Date: Thu, 17 Nov 2005 19:59:54 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: [-mm patch] kernel/signal.c: fix compile warning
References: <20051117111807.6d4b0535.akpm@osdl.org> <20051118014102.GL11494@stusta.de>
In-Reply-To: <20051118014102.GL11494@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Nov 17, 2005 at 11:18:07AM -0800, Andrew Morton wrote:
> 
>>...
>>Changes since 2.6.14-mm2:
>>...
>>+sigaction-should-clear-all-signals-on-sig_ign-not-just.patch
>>
>> Signal code fix
>>...
> 
> 
> 
> Patches get bonus points when they don't introduce new compile 
> warnings...

Even more when the fix them.  My loss, your gain :).  Still I wonder 
why I did not see that.

George
-- 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
