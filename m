Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWEAIHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWEAIHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEAIHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:07:49 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:32477 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1751305AbWEAIHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:07:48 -0400
Message-ID: <4455C1D0.5060104@dunaweb.hu>
Date: Mon, 01 May 2006 10:07:44 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Bad page state in process 'nfsd' with xfs
References: <4454D59C.7000501@dunaweb.hu> <20060501102440.A1864834@wobbly.melbourne.sgi.com>
In-Reply-To: <20060501102440.A1864834@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nathan Scott írta:
> On Sun, Apr 30, 2006 at 05:19:56PM +0200, Zoltan Boszormenyi wrote:
>   
>> ...
>> Or not. I had an FC3/x86-64 system until two days ago, now I have FC5/86-64.
>>
>> When FC3 was installed I chose to format the partitions to XFS and since 
>> then
>> I had Oopses regularly with or without VMWare modules.
>>     
>
> What was the stack trace for your oops...?
>
> cheers.
>   

I reported some Oopses for earlier kernels, they are here:

http://marc.theaimsgroup.com/?t=113649735300003&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=113166035904096&w=2
http://marc.theaimsgroup.com/?l=fedora-list&m=113611408900505&w=2

With FC3, the last kernel I used was vanilla 2.6.15.
It may be that those above were fixed since.

Best regards,
Zoltán Böszörményi

