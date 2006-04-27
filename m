Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWD0Pbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWD0Pbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWD0Pbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:31:32 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:18192 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030187AbWD0Pbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:31:31 -0400
Message-ID: <4450E3CB.1090206@argo.co.il>
Date: Thu, 27 Apr 2006 18:31:23 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il> <mj+md-20060427.145744.9154.atrey@ucw.cz>
In-Reply-To: <mj+md-20060427.145744.9154.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 15:31:29.0472 (UTC) FILETIME=[A78CE400:01C66A0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
>> As an example, you can easily get C++ to inline the hash function in a 
>> generic hashtable or the compare in a sort. I dare you to do it in C.
>>     
>
> As you wish :-)
>
> http://atrey.karlin.mff.cuni.cz/~mj/tmp/hashtable.h
>   
Touche :)

This is pushing all boundaries, however. That code is horrible.
> It's somewhat ugly inside, but an equally strong generic structure build
> with templates will be probably even uglier.
>
>   
Not at all.

-- 
error compiling committee.c: too many arguments to function

