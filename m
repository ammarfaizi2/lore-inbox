Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWCPTGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWCPTGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWCPTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:06:48 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:16140 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964848AbWCPTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:06:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lRpymyD9rseuEzxHsuu8ZHHUlIt6PqGkDAhhnyZSvU59GzPxHjxOBWvvgvdsjZCeY5STKgmWtncpbUyHmGtOC00M52ydxLavRItXk6Jphpj4sa5Ihgc2X786wdKe8zjoV8f6n+l9oM5EmXIVoGdKIaUbS6Cc21Q0jkJnzdVDcpU=
Message-ID: <4419B73D.8080901@gmail.com>
Date: Fri, 17 Mar 2006 04:06:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au> <20060313091254.GA28231@mars.ravnborg.org> <44154DAC.6050006@yahoo.com.au> <20060313163041.GA29719@mars.ravnborg.org> <4419AEEA.50702@gmail.com> <20060316183703.GB21003@mars.ravnborg.org>
In-Reply-To: <20060316183703.GB21003@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Mar 17, 2006 at 03:31:06AM +0900, Tejun Heo wrote:
>  Wouldn't it be better to have an option to tell make to assume the old 
> 
>>behavior? I only skimmed the original thread but it didn't seem terribly 
>>complex thing to do. A LOT of people will be doing things on pre-2.6.17 
>>kernel for quite some time and they will be cursing a lot if they have 
>>to rebuild everything everytime.
> 
> 
> If Paul planned for a new make relase this year - then yes.
> But I assume it will take another year (almost) before next make realse
> after the current 3.81. And then it should not matter much.
> 

Fair enough for me. :-)

-- 
tejun
