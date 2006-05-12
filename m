Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWELPmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWELPmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWELPmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:42:42 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:52969 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751279AbWELPml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:42:41 -0400
Message-ID: <4464ACED.2010206@bootc.net>
Date: Fri, 12 May 2006 16:42:37 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
Cc: Tejun Heo <htejun@gmail.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <44649CE1.4060407@bootc.net>
In-Reply-To: <44649CE1.4060407@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Tejun Heo wrote:
>> Patches against v2.6.16.16 is avaialbe at the following URL.
>>
>>  http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.16.16-20060512.tar.bz2 
>>
>>
>> Please read README carefully before testing the patches.  Keep in mind
>> that these are still quite experimental and not ready for production
>> use.
> 
> Are these patches likely to work alongside Alan's PATA patches? 
> Specifically I have a DVD-RW and an IDE tape that I'd like to use.

I'll answer my own question: this fails miserably!

I'll test 'em anyway, screw the DVD and tape for now. :-P

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
