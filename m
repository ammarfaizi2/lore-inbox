Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVDUIqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDUIqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDUIq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:31763 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261480AbVDUIpY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 04:45:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FYggiEZNrcMt+2hXf8t7tbPvWii43XsUhNZiTgg/9Gn3lpi3BjMETM8cBDPOaM4D5HSQz9MzErDb0EyU0FBN0SPqytD+MW42kv/cnuSJ3SA4WbHBUyKz4P2yf/uT0qocLMx6aRo1XfEZZYedk1BORgGHomUPeYt86PAmHn4e+Bs=
Message-ID: <4d8e3fd305042101457589b480@mail.gmail.com>
Date: Thu, 21 Apr 2005 10:45:24 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-00
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050421073537.GA1004@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <20050421073537.GA1004@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/4/21, Ingo Molnar <mingo@elte.hu>:
> 
> i have released the -V0.7.46-00 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> this is a merge to 2.6.12-rc3, plus the 'ping localhost' fix from
> yang.yi@bmrtech.com.
> 
> there are still some unsolved slowdowns probably related to the recent
> plist.h changes.
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc3-V0.7.46-00
> 

Ingo,
what's your plan for including in mainstream bit of preemptive patch ?

-- 
http://paoloc.blogspot.com
