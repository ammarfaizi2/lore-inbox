Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVHDMTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVHDMTC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVHDMSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:18:48 -0400
Received: from mail.isurf.ca ([66.154.97.68]:9437 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S262507AbVHDMSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:18:43 -0400
Message-ID: <42F207BE.40609@staticwave.ca>
Date: Thu, 04 Aug 2005 08:19:10 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
References: <200508031758.31246.kernel@kolivas.org> <200508042146.13710.kernel@kolivas.org> <42F2047A.1050906@staticwave.ca> <200508042204.57977.kernel@kolivas.org>
In-Reply-To: <200508042204.57977.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> I'd appreciate it. It's almost like some power stepping that's responsible. 
> I've never seen it happen on any intel processor (including the pentiumM ones 
> which have truckloads of power saving features). I've asked many people if 
> they're running some equivalent of cool'n'quiet or powernow* and they all 
> insist they're not... I'm not that familiar with all the powersaving techs 
> though.

I'm certainly not running any powersaving features on my athlon-tbird(it 
doesn't have any AFAIK, and its the hottest running AMD processor there 
is) However I've realized I did have cool n' quiet with the ondemand 
governor running on my athlon64, so that might indicate an issue, again, 
I'll look into that tonight.

--
Gabriel Devenyi
ace@staticwave.ca
