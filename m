Return-Path: <linux-kernel-owner+w=401wt.eu-S932148AbXAPCCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbXAPCCv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXAPCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:02:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:4402 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148AbXAPCCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:02:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SJ7cGl8m9QILlMqj2SOnmjHfiKmFkSKTf22+Y7sezVvWQ9dmlCTadcmLJWJOJOt1U5cBrBtBqw1XxeBcqKNkG1DZIYaOnOXF2BHIThGrJjKcWUJtk0obUi5nypxroK/RwjqbzeymdUormKg8XEeuEJibLakNBnvKc3A62HtYzgI=
Message-ID: <45AC3214.4080800@googlemail.com>
Date: Tue, 16 Jan 2007 03:01:56 +0100
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Miller <davem@davemloft.net>, dlstevens@us.ibm.com, dsd@gentoo.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] 2.6.19.2 regression introduced by "IPV4/IPV6: Fix inet{,
 6} device initialization order."
References: <45AAF3AC.3070600@gentoo.org> <OF0ECEC103.470302BB-ON88257264.00142A49-88257264.0014DC27@us.ibm.com> <20070114.213008.74745274.davem@davemloft.net> <20070115072554.GA16969@kroah.com>
In-Reply-To: <20070115072554.GA16969@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH schrieb:
> On Sun, Jan 14, 2007 at 09:30:08PM -0800, David Miller wrote:
>   
>> From: David Stevens <dlstevens@us.ibm.com>
>> Date: Sun, 14 Jan 2007 19:47:49 -0800
>>
>>     
>>> I think it's better to add the fix than withdraw this patch, since
>>> the original bug is a crash.
>>>       
>> I completely agree.
>>     
>
> Great, can someone forward the patch to us?
>   

Should be the fix from http://bugzilla.kernel.org/show_bug.cgi?id=7817

> thanks,
>
> greg k-h
>   

Regards,

Gabriel

