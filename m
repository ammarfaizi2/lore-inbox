Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVELSWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVELSWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVELSWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:22:17 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:57085 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262099AbVELSVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:21:42 -0400
Message-ID: <42839EAC.3070802@tiscali.de>
Date: Thu, 12 May 2005 20:21:32 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: Scott Robert Ladd <lkml@coyotegulch.com>, linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation
References: <42839AF7.4030708@coyotegulch.com> <42838D4C.3040207@utah-nac.org>
In-Reply-To: <42838D4C.3040207@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:
> Scott Robert Ladd wrote:
> 
> Now that's a great idea ..... :-)
> Jeff
> 
>> Is there a utility that creates a .config based on analysis of the
>> target system?
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>  
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
I think Netbsd has something like this, maybe this is a good example.

Matthias-Christian Ott
