Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVADML4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVADML4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVADMLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:11:55 -0500
Received: from main.gmane.org ([80.91.229.2]:61660 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261399AbVADMLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:11:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: cpu throttling powernow-k8 and acpi in kernel
Date: Tue, 04 Jan 2005 13:11:18 +0100
Message-ID: <41DA87E6.4080901@gmx.net>
References: <41D80CAB.1060903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83.215.48.11
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
In-Reply-To: <41D80CAB.1060903@gmx.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Schild wrote:
> Hi guys!
> 
> I have an acer aspire 1501 lmi with amd64 @3000+. i am running a gentoo 
> 64bit dist with vanilla 2.6.10 kernel on it.
> 
> i encounter some problems with the speed throttling of the cpu. this 

Just for telling you what has caused my cpu to spin down all the time. 
it looks like the acpi was right to tell me that the laptop got very 
hot, i just didn't notice cause the air out of the laptop wasn't hot, 
this was because some dust was somewhere in the fan/heatpipe which 
caused the machine to overheat. now i know a bit more, acpi was right in 
throttling the cpu, thank god for acpi ;)

cya and keep on the good work

Georg Schild

