Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVBQO41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVBQO41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVBQOyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:54:45 -0500
Received: from mail.capitalgenomix.com ([143.247.20.203]:23718 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S262191AbVBQOww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:52:52 -0500
Message-ID: <4214AFC1.9080500@capitalgenomix.com>
Date: Thu, 17 Feb 2005 09:52:49 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Massimo Cetra <mcetra@navynet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter: TARPIT Target
References: <20050217145013.2C6E484008@server1.navynet.it>
In-Reply-To: <20050217145013.2C6E484008@server1.navynet.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Cetra wrote:

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Fao, Sean
>>Sent: Thursday, February 17, 2005 3:42 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: Netfilter: TARPIT Target
>>
>>I wanted to use the TARPIT target provided by Netfilter, but 
>>I am unable to find the module in the kernel.  Has it been 
>>removed or am I looking in the wrong place?
>>    
>>
>
>http://www.netfilter.org/patch-o-matic/pom-extra.html#pom-extra-TARPIT
>
>TARPIT is in the extra repository.
>Use patch-o-matic to patch both kernel and iptables source.
>  
>

That would explain it.  Than you much!

-- 
Sean
