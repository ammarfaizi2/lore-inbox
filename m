Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWHLQkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWHLQkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWHLQkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:40:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60761 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964887AbWHLQkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:40:16 -0400
Message-ID: <44DE046D.2050304@de.ibm.com>
Date: Sat, 12 Aug 2006 18:40:13 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com> <20060811220728.GI479@krispykreme>
In-Reply-To: <20060811220728.GI479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 
>>     
>
>   
>> +extern void exit(int);
>>     
>
> Should be able to remove that prototype :) 
>
> Anton
>   
Indeed :-) It's gone.

Thomas

