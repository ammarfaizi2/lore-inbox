Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUEMMBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUEMMBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUEMMBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:01:53 -0400
Received: from main.gmane.org ([80.91.224.249]:16343 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264002AbUEMMBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:01:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: swsusp + APM in 2.6.6
Date: Thu, 13 May 2004 08:01:56 -0400
Message-ID: <c7vo3c$hfu$1@sea.gmane.org>
References: <1084411449.2562.20.camel@ansel.lan> <20040513114250.GB16524@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <20040513114250.GB16524@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should be able to accomplish the same thing with "echo disk > 
/sys/power/state", as it says in the same file.

Aristeu Sergio Rozanski Filho wrote:
> 
>>>In 2.6.6, however, using the same kernel configuration, neither
>>>/proc/sleep or /proc/acpi/sleep exist! I _do_ have swsusp enabled in the
>>>kernel, as well as ACPI sleep states (do they do anything if you disable
> 
> please check
> http://marc.theaimsgroup.com/?l=bk-commits-head&m=108423574229098&w=2
> 

