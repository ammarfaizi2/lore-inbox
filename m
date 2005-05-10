Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVEJO7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEJO7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVEJO7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:59:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20143 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261663AbVEJO7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:59:40 -0400
Message-ID: <4280CC43.4060002@austin.ibm.com>
Date: Tue, 10 May 2005 09:59:15 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Derbey Nadia <Nadia.Derbey@bull.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Automatic Kernel Tunables
References: <42806DF8.8020503@bull.net>
In-Reply-To: <42806DF8.8020503@bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. making the kernel able to automatically tune the resources as it sees 
> appropriate. This is a much more complicated feature that will be 
> considered as a second step for the project

You might be interested in the work Jacob Moilanen has been doing with 
genetic algorithm tuning of I/O and CPU schedulers.  Google will 
probably turn up some discussion on this.  Also, he is scheduled to give 
a presentation and paper on this topic at the Ottawa Linux Symposium in 
July.

