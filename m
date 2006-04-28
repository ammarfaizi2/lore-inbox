Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWD1Qvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWD1Qvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWD1Qvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:51:35 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:18953 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1030452AbWD1Qve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:51:34 -0400
Message-ID: <44524811.4060405@argo.co.il>
Date: Fri, 28 Apr 2006 19:51:29 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il> <Pine.LNX.4.61.0604281748470.9011@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604281748470.9011@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 16:51:32.0810 (UTC) FILETIME=[00F9DAA0:01C66AE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> It still can't typecheck void pointers. With C++ they're very rare.
>>
>>     
> Using C++ just because one can't verify that all type conversions in a C 
> program from/to void* are as they are supposed to be is... well, think of 
> something.
>   

If you remove the 'just', I'd say 'a way to catch more bugs at compile 
time'.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

