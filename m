Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWB1Gnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWB1Gnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWB1Gnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:43:42 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:31582 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932079AbWB1Gnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:43:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fXZx18bKLJ1b2hgR/3jJ95CI/GA3JjGW1xB46I6nYp8IEAdfEGOesZmNKZPiLsWUbgeGTW1TIxnRL0ajXdX23Vq4T/c37lAcwuSnaDKi+aHNRpRzm68eYnOTn/YwgzGgYv9ZKA0dunojyY8x4ai+nNzbcgJg8oOYe0g9UQNuxYs=
Message-ID: <4403F119.8020509@gmail.com>
Date: Tue, 28 Feb 2006 15:43:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian McDonald <imcdnzl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem making kernel with debian unstable due to make upgrade
References: <cbec11ac0602271655p70669d4bi99096282a5e0b86e@mail.gmail.com>
In-Reply-To: <cbec11ac0602271655p70669d4bi99096282a5e0b86e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian McDonald wrote:
> Folks,
> 
> If anybody else is banging their heads against the wall and uses
> debian unstable this seems to be due to a make bug in the current
> version.
> 
> In particular mine happened with make going from 3.80+3.81.b4-1 to
> 3.80+3.81.rc1-1
> 
> There is a bug report at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=354602
> 
> Just to let you know as I'm sure others of you will soon be as
> frustrated as me - particularly when I have a box that takes an hour
> to compile....
> 

I was scratching my head for more than three hours now. Thanks for 
notifying. So, make it was. :-(

-- 
tejun
