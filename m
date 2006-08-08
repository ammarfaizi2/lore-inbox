Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWHHJAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWHHJAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWHHJAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:00:24 -0400
Received: from smtp.hickorytech.net ([216.114.192.16]:41634 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S932551AbWHHJAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:00:23 -0400
Message-ID: <44D852A5.3080008@mnsu.edu>
Date: Tue, 08 Aug 2006 04:00:21 -0500
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
Cc: Manuel Reimer <Manuel.Spam@nurfuerspam.de>, linux-kernel@vger.kernel.org
Subject: Re: Is XFS trustworthy in the latest 2.6.16
References: <eb9epf$dse$1@sea.gmane.org> <20060808185017.A2528231@wobbly.melbourne.sgi.com>
In-Reply-To: <20060808185017.A2528231@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Tue, Aug 08, 2006 at 09:34:48AM +0200, Manuel Reimer wrote:
>   
>> Hello,
>>
>> could someone please tell me if XFS is trustworthy in the latest 2.6.16? 
>> There have been some bugs:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=6380
>> http://bugzilla.kernel.org/show_bug.cgi?id=6757
>>     
>
> These are the same problem.  2.6.16 is unaffected.
>
>   
>> want a stable kernel and 2.6.16 seems to fit all my needs.
>>     
>
> For XFS, its goodness.  2.6.18 will be good too, and 2.6.17.7+.
>
> cheers.
>
>   

If you have run 2.6.17 to 2.6.17.6 or early 2.6.18-rc? however; please 
run a xfs_repair v.2.6.10; because the corruption may/will have already 
taken place and a silent time bomb may be waiting.  Three machines 
already died with symptom of the corruption on kernels that no longer 
have the problem.

-- 
Jeffrey Hundstad



