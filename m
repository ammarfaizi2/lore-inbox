Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWD0VBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWD0VBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWD0VBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:01:12 -0400
Received: from smtp-out.google.com ([216.239.33.17]:1776 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751668AbWD0VBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:01:11 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=SlPfcjUKLUS7Qnxx3tuKig2LeGIH8zYeSjX22cs+BS63B94UISCsFXV5Z6DUpcWeg
	USQXMG/NUw6I10Nw1xslA==
Message-ID: <445130E7.3060402@google.com>
Date: Thu, 27 Apr 2006 14:00:23 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
References: <20060427014141.06b88072.akpm@osdl.org> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com> <200604272156.11606.ak@suse.de>
In-Reply-To: <200604272156.11606.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some Unixes have a cstyle(1). Maybe there is a free variant of it somewhere.
> But such a tool might put a lot of people on l-k out of job @)

heh. we could do some basic stuff at least. run through lindent, and see
if it changes ;-)

>>The others all look doable.
>>
>>The intent would not be that you get burdened with this, but that
>>developers send it there before sending it to you. It could even
>>hand out
> 
> It would be better to automate this - not require the developers
> to do lots of manual steps.

Can't tell whether that was meant to be positive or negative feedback.
All this would require is "email patch to test-thingy@test.kernel.org".

M.
