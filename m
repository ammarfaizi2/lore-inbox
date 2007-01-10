Return-Path: <linux-kernel-owner+w=401wt.eu-S965007AbXAJRbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbXAJRbv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbXAJRbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:31:51 -0500
Received: from smtp50.hccnet.nl ([62.251.0.47]:34843 "EHLO smtp50.hccnet.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965000AbXAJRbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:31:49 -0500
Message-ID: <45A52320.2050100@hccnet.nl>
Date: Wed, 10 Jan 2007 18:32:16 +0100
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oprofile broken on 2.6.19
References: <45A3FF3E.7060109@hccnet.nl> <45A525B6.5030709@dbservice.com>
In-Reply-To: <45A525B6.5030709@dbservice.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:
> Gert Vervoort wrote:
>   
>> When I try to use oprofile on 2.6.19, it does not seem to work:
>>
>>     
>
> http://lkml.org/lkml/2006/11/22/172
>
> tom
>
>
>   
Disabling the nmi watchdog, as suggested in: 
http://marc.theaimsgroup.com/?l=oprofile-list&m=116422889324043&w=2, 
also makes oprofile work again.
  
   Gert


