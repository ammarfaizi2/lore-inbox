Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVGZBbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGZBbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGZBbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:31:48 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:5483 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVGZBbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:31:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VMPwucxta6vaU4DLjcY6ZO8H5nLEasce9rAV2MtZ5alZyso8Y98NMs372r/OjB1Tu4HpLJzZlykRvz6MTX/HRkoCN7O2kDrSmYElj5jWQEXvYQeVGCReXFJF4A5uqcCz6c9dAD8JlaPLn+wHcRgRVRoWMZvkq3vwS1x4PWuc0DY=
Message-ID: <42E5927B.20506@gmail.com>
Date: Mon, 25 Jul 2005 21:31:39 -0400
From: Puneet Vyas <vyas.puneet@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org>
In-Reply-To: <42E57ACD.8070909@linuxwireless.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:

> Puneet Vyas wrote:
>
>>
>> PS : I am not even sure if I am "allowed" to pull out the writer like 
>> this. Am I supposed to "stop" the device first or something?
>>
> You are supoused to unmount the volume. Try it. umount /dev/cdrom ? 
> Make sure that is it not in use, then unload it.
> New versions of gnome and so have the option to right click the loaded 
> device and then to unmount.
>
> It should never hang. Does it hang with the floppy when removed?

1. When I did umount /dev/cdrom it says - "umount: /dev/hdc is not 
mounted (according to mtab)"
2. Yes

Thanks,
Puneet
