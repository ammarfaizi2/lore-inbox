Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVKVL55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVKVL55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVKVL55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:57:57 -0500
Received: from mx02.stofanet.dk ([212.10.10.12]:29618 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S964926AbVKVL55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:57:57 -0500
Message-ID: <4383078A.5010204@stud.feec.vutbr.cz>
Date: Tue, 22 Nov 2005 12:56:58 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: ioscheduler and 2.6 kernels
References: <20051122115225.GA2529@mail.muni.cz>
In-Reply-To: <20051122115225.GA2529@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> Hello,
> 
> I have a question about ioschedulers in current 2.6 kernels. Is there an option
> to build iorequest queues per process? I would like to have the queue for each
> process and pick up request in round robin manner, which results in more
> interactive environment. 

Isn't this exactly what the CFQ scheduler does?
Michal


