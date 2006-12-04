Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936980AbWLDPc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936980AbWLDPc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936998AbWLDPc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:32:58 -0500
Received: from il.qumranet.com ([62.219.232.206]:44571 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936980AbWLDPc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:32:57 -0500
Message-ID: <45743FA7.1030102@qumranet.com>
Date: Mon, 04 Dec 2006 17:32:55 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: mmu: honor global bit on huge pages
References: <20061204145735.89391A0016@il.qumranet.com> <45743E0C.6090705@mandic.com.br> <45743ECD.9050105@qumranet.com>
In-Reply-To: <45743ECD.9050105@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>>
>> Whats wrong? :-(
>>   
>
> This patch is for kvm, which lives in the -mm kernel.  Apply the 
> latest -mm patch first.
>
>

Oh, and visit http://kvm.sourceforge.net first :)

-- 
error compiling committee.c: too many arguments to function

