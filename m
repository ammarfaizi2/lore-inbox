Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbTL3TzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbTL3TzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:55:11 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:24201 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265905AbTL3TyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:54:23 -0500
Message-ID: <3FF1D7EE.5050603@rackable.com>
Date: Tue, 30 Dec 2003 11:54:22 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad House <brad_mssw@gentoo.org>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, Atul.Mukker@lsil.com
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>        <20031230052041.GA7007@gtf.org>        <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>        <3FF11CC2.7040209@pobox.com>        <3FF1D567.4040205@rackable.com> <33036.209.251.159.140.1072813780.squirrel@mail.mainstreetsoftworks.com>
In-Reply-To: <33036.209.251.159.140.1072813780.squirrel@mail.mainstreetsoftworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2003 19:54:22.0332 (UTC) FILETIME=[B83293C0:01C3CF0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad House wrote:
> Well, I thought this was megaraid2
> from the .h file:
> #define MEGARAID_VERSION        \
>         "v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST 2003)\n"
> 
> Perhaps I should search around and see if I can find a later one
> though ??
> 

   There is a 2.00.9 in 2.4.  In theory you should really be asking on
linux-megaraid-devel@dell.com.
> 
> 
>>   Wouldn't it be more useful to port megaraid2 from 2.4?
>>
>>--
>>There is no such thing as obsolete hardware.
>>Merely hardware that other people don't want.
>>(The Second Rule of Hardware Acquisition)
>>Sam Flory  <sflory@rackable.com>
> 
> 
> 
> 


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

