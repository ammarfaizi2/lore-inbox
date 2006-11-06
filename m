Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423622AbWKFIvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423622AbWKFIvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423624AbWKFIvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:51:55 -0500
Received: from il.qumranet.com ([62.219.232.206]:33234 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423622AbWKFIvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:51:54 -0500
Message-ID: <454EF7A8.10504@argo.co.il>
Date: Mon, 06 Nov 2006 10:51:52 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kvm howto
References: <4549F1D5.8070509@qumranet.com> <20061105171424.GA7045@irc.pl>
In-Reply-To: <20061105171424.GA7045@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Thu, Nov 02, 2006 at 03:25:41PM +0200, Avi Kivity wrote:
>   
>> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including 
>> (hopefuly) everything needed to get kvm running.  Please take a look and 
>> comment.
>>     
>
>   I have some problems on Thinkpad z61t with Core Duo T2500.
> /proc/cpuinfo shows "vmx" in flags, but module refuses to load:
> [17462106.632000] kvm: disabled by bios
>
>   

See 
http://forum.thinkpads.com/viewtopic.php?p=203419&sid=8f3fe5a07430fe35c6bf8c32e6058a87


>  I wandered around BIOS setup (latest version), but didn't found
> anything about virtualization. Is BIOS check really necessary?
>   

Yes.  The thing is a brick as far as hardware virtualization is 
concerned.  Complain to your vendor.

-- 
error compiling committee.c: too many arguments to function

