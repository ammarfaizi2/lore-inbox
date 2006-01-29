Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWA2Axa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWA2Axa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWA2Axa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 19:53:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:27960 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWA2Ax3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 19:53:29 -0500
Message-ID: <43DC11EA.1030206@google.com>
Date: Sat, 28 Jan 2006 16:52:58 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org> <43D52E6F.7040808@google.com> <43D5821A.7050001@bigpond.net.au> <43D5A3F0.1000206@bigpond.net.au> <43D5AFF9.10608@google.com> <43D5C7AE.6040207@bigpond.net.au> <43D5CC4F.3000300@google.com> <43DBFC34.3010003@bigpond.net.au>
In-Reply-To: <43DBFC34.3010003@bigpond.net.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Looking at the latest results for 2.6.16-rc1-mm3, it appears to me 
> that this is no longer an issue.  Do you agree?
>
> Peter

Yes, -mm3 looks OK ... not sure what happened, but as long as it works 
... ;-)

M.
