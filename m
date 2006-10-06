Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJFFco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJFFco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWJFFco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:32:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:62843 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751351AbWJFFcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:32:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=RK9aPvq0W3bTSeMV+EE4tqQoi+sSrqsKHhcMzaE5QuLwAexzbAUiQzXTy2ARV2i2zMadfDK14j7QyOm9tlannwajcnDDzWZKEsTG1KB/6llqli6ci15LenwrFlDc9jO4QMxCIe8NsM4qqsyr2BHA2oGiWU5aQWARczuRccwtCg0=
Message-ID: <4525EA74.7030701@web.de>
Date: Fri, 06 Oct 2006 07:32:36 +0200
From: Markus Wenke <M.Wenke@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: to many sockets ?
References: <4523CD4E.10806@web.de>	 <1159979587.25772.82.camel@localhost.localdomain> <4524B0E9.8010005@web.de> <1160083851.1607.22.camel@localhost.localdomain>
In-Reply-To: <1160083851.1607.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox schrieb:
> Ar Iau, 2006-10-05 am 09:14 +0200, ysgrifennodd Markus Wenke:
>   
>> and the oom-killer kills my application at the same time (at 140000 
>> connections).
>>
>> I can not see in the messages that the system is out of memory,
>> there is also no swap space used
>>
>> You can download my /var/log/messages at 
>> http://hemaho.mine.nu/~biber/messages
>>
>> May you can give me a hint which line/value in the log shows me,
>> that the system is out of memory?
>>     
>
> That sounds like a bug. What kernel are you using ?
>   

I use 2.6.18 with this config:: http://hemaho.mine.nu/~biber/.config


Markus
