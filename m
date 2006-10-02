Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWJBRfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWJBRfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWJBRfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:35:15 -0400
Received: from lanshark.nersc.gov ([128.55.16.114]:59271 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S965162AbWJBRfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:35:13 -0400
Message-ID: <45214DC3.9090903@nersc.gov>
Date: Mon, 02 Oct 2006 10:34:59 -0700
From: Thomas Davis <tdavis@nersc.gov>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org>
In-Reply-To: <20061002100302.GS16047@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
> I can do fairly easily "this address is allowed to post" type
> filters at Majordomo - it has a way to specify allowed posters.
> Usually it is used to permit list members to post, but it can
> also be configured to use other datasets.
> 
> 

Sounds like a version of greylisting.

I know, people will argue against it - but it does work, and it 
still works.  I use it on website I run, and it cuts 2k+ spams per 
day into about 50 that spamassassin has to process.

Yes, there are broken mailers that cannot deal with it properly. 
They should fix their mailers..

thomas
