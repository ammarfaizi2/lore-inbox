Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbVHJS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbVHJS2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVHJS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:28:35 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:3438 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965244AbVHJS2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:28:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=uQn62tBl1cozmmwycaltFMgxXMaQSYF0AtxA2MU+m5/L1nM/te95NmGpJGK7Mgy+U8jOqmXjjuaZfWD9cvwTrgi6PJSWFSofepIgqK1BCykVknylmF+fdID3fb6Ykniz3xqhmBAJ5Gjwo5v2Dol3O6X/Cl9U38A6Lg8cgoSqJd8=
Message-ID: <42FA4745.4040900@gmail.com>
Date: Wed, 10 Aug 2005 20:28:21 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <42FA4355.7010004@gmail.com> <42FA4502.8000807@pobox.com>
In-Reply-To: <42FA4502.8000807@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Michael Thonke wrote:
>
>> Hello Jeff,
>>
>> I would like to ask what the plans/timeplan to implement NCQ support 
>> for NVidia NForce4(CK804) SATAII based chipsets? Fact is that is it 
>> possible to use NCQ with NForce4 SATAII on Windows system, I wonder 
>> why it isn't support by libata? Is there something in your git-tree? 
>> Or what are the reasons/problems behind that libata is missing NCQ 
>> support for (CK804) SATAII?
>
>
> Ask NVIDIA.  They are the only company that gives me -zero- 
> information on their SATA controllers.

I thought of that.. *sigh*

>
> As such, there are -zero- plans for NCQ on NVIDIA controllers at this 
> time.

Could it be possible to make reverse engeneering? I think they should 
work as the SATA-IO SATAII specification says.

Jeff, I will also contact NVidia to ask for specification or information 
about it.

>
>     Jeff
>
>
>
>
/Michael

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



