Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268788AbUHWXoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268788AbUHWXoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUHWXgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:36:08 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:18141 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268501AbUHWXel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:34:41 -0400
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de> <412A663D.2050104@kolivas.org>
Message-ID: <cone.1093304064.895888.10766.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Prakash =?ISO-8859-1?B?Sy4=?= Cheemplavam <prakashkc@gmx.de>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       Joshua Schmidlkofer <menion@asylumwear.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
Date: Tue, 24 Aug 2004 09:34:24 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas writes:

> Prakash K. Cheemplavam wrote:
>> Joshua Schmidlkofer wrote:
>> | I don't know what or why, but I am experiancing a nightmare with
>> | interactivity and heavy nfs use.   I am using Gentoo, and I have my
>> | portage tree exported from a central server.   Trying to do an emerge
>> | update world is taking forever.
>> 
>> [snip]
>> 
>> Yup I think I have a regression here, as well. I remember an older
>> version of ck exhibited this, but the last one for 2.6.7 did work well
>> (I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
>> doing a (niced) compile in background, some windows react very slow, ie
>> Mozilla Thunderbird takes ages to switch trough mails or cliking on an
>> icon in kde to load up konsole takes about 10seconds or more (shoud come
>> up <1sec normally).
>> 
>> Using 2.8.6.1-ck4
>> 
>> HTH,
>> 
>> Prakash
> 
> For both of you this only happens with NFS? Can you reproduce the 
> problem in flight and send me the output of 'top -n -n 1' while it's 
> happening? Also if you have time can you confirm this happens with just 
> the staircase patch and none of the other patches?

blah... I mean `top -b -n 1`

Con

