Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVIHRfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVIHRfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVIHRfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:35:21 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:58187 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964900AbVIHRfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=bcTZDe9ETZckuxMv5x19b5b34gtxeyUDqv/dhsshBt616WcB9mSpm/Zd7HeXJ9kVF5HIeBU7uz6HWrhJxX+KlJDff9rTUiM75usCqB4//zX1/AVA224kt9YQa6LffJebg3oLPn6ISVJszFsDRgvCJSUI0/VdRBn40fCEYC1cCQo=
Message-ID: <43207657.9020907@gmail.com>
Date: Thu, 08 Sep 2005 19:35:19 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050823)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: ress.weber@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: How to plan a kernel update ?
References: <9c23279705090810123132447d@mail.gmail.com>
In-Reply-To: <9c23279705090810123132447d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I won't be harsh but google is your best friend and first source for it.

please take a look at:

http://linuxdevices.com/articles/AT3855888078.html

They have a good guide and what should need attention in migrating to Kernel 2.6 
They also have related articles for drivers in Kernel 2.6,NPTL and such.

Best regards

--
Michael Thonke



Weber Ress schrieb:

>Hi,
>
>I'm responsible to planning a kernel upgrade in many servers, from 2.4
>version to 2.6.13 (last stable version), using Debian 3.1r0a
>
>My team has good technical skills, but they need to be led. I would
>like know, what's the best pratices and recommendations that a project
>manager need think BEFORE an kernel upgrade.
>
>A technical guy have a particular vision about this upgrade, but I
>will be very been thankful if I receive from this community another
>vision.. a vision centered in the project process (planning,
>executing, controlling) to make this activity successfully.
>
>Thank's !
>
>Weber Ress
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

