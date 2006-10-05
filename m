Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWJEBIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWJEBIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJEBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:08:21 -0400
Received: from dvhart.com ([64.146.134.43]:50565 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751297AbWJEBIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:08:20 -0400
Message-ID: <45245B03.2070803@mbligh.org>
Date: Wed, 04 Oct 2006 18:08:19 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Steve Fox <drfickle@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
References: <20060928014623.ccc9b885.akpm@osdl.org> <20061004170659.f3b089a8.akpm@osdl.org> <20061005005124.GA23408@in.ibm.com> <200610050257.53971.ak@suse.de>
In-Reply-To: <200610050257.53971.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>I think most likely it would crash on 2.6.18. Keith mannthey had reported
>>a different crash on 2.6.18-rc4-mm2 when this patch was introduced first
>>time. Following is the link to the thread.
> 
> 
> Then maybe trying 2.6.17 + the patch and then bisect between that and -rc4?

I think it's fixed already in -git22, or at least it is for the IBM box
reporting to test.kernel.org. You might want to try that one ...

M.
