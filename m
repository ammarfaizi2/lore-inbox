Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVIUFDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVIUFDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 01:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVIUFDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 01:03:34 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:51874 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751028AbVIUFDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 01:03:33 -0400
Message-ID: <4330E99A.5000506@nortel.com>
Date: Tue, 20 Sep 2005 23:03:22 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: help interpreting oom-killer output
References: <4OY0C-5kE-59@gated-at.bofh.it> <4330A116.1040107@shaw.ca>
In-Reply-To: <4330A116.1040107@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 05:03:23.0990 (UTC) FILETIME=[CB332F60:01C5BE69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Looks like you were running out of ZONE_NORMAL memory (below 896MB). 
> There is lots of high memory available but the allocation could not be 
> satisfied from there.

Thanks for the interpretation.

> I would try a newer kernel..

I wish.   Newer kernel is not an option.  Any fixes need to be back-ported.

Chris

