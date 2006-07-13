Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWGMMUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWGMMUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGMMUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:20:06 -0400
Received: from mail.bowes.com ([66.38.194.194]:62639 "EHLO mail.bowes.com")
	by vger.kernel.org with ESMTP id S932507AbWGMMUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:20:02 -0400
Message-ID: <44B63A62.9040408@bowes.com>
Date: Thu, 13 Jul 2006 08:19:46 -0400
From: Paul Paquette <paulp@bowes.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops during rsync
References: <200607130045_MC3-1-C4D4-AC62@compuserve.com>
In-Reply-To: <200607130045_MC3-1-C4D4-AC62@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chuck Ebbert wrote:
> In-Reply-To: <44B5452B.4070503@bowes.com>
>
>
> On Wed, 12 Jul 2006 14:53:31 -0400, Paul Paquette wrote:
>
>   
>> Below is the oops, then the kernel config and system map.
>>     
>
>   
>> ...
>>     
>
>   
>> Call Trace:
>>  [<c0162b68>] dquot_drop+0x35/0x68
>>     
>
> Is that the whole trace?  It should be longer and there should be a Code:
> line as well.
>
>   
That was what was left in the logs on the disk after a reboot.

-- 
Paul Paquette
Programmer/Analyst
Bowes Publishers Ltd.
Subsidiary of Sun Media Corporation
A Quebecor Company
paulp@bowes.com
(519) 471-8520 x377


