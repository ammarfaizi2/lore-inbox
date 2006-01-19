Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161424AbWASUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161424AbWASUyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWASUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:54:04 -0500
Received: from dvhart.com ([64.146.134.43]:3968 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161424AbWASUyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:54:03 -0500
Message-ID: <43CFFC69.5070401@mbligh.org>
Date: Thu, 19 Jan 2006 12:54:01 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Out of Memory: Killed process 16498 (java).
References: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chittenden wrote:
> Why does running the following command cause processes to be killed:
> 
> 	dd if=/dev/zero of=/u/u1/andyc/tmpfile bs=1M count=8k
> 
> And I noticed one of my windows disappeared. Further investigation
> showed that was my terminator window (java based app: see
> http://software.jessies.org/terminator/). I found this in my syslog:
> 
> Jan 17 11:12:58 boco kernel: Out of Memory: Killed process 16498 (java).

Ah well. You can't fault us for having good taste ;-)

M.
