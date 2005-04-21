Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVDUQRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDUQRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVDUQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:16:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44787 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261500AbVDUQQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:16:35 -0400
Date: Thu, 21 Apr 2005 09:16:28 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-00
In-Reply-To: <20050421073537.GA1004@elte.hu>
Message-ID: <Pine.LNX.4.44.0504210915150.19107-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005, Ingo Molnar wrote:

> 
> i have released the -V0.7.46-00 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is a merge to 2.6.12-rc3, plus the 'ping localhost' fix from 
> yang.yi@bmrtech.com.
> 
> there are still some unsolved slowdowns probably related to the recent 
> plist.h changes.

You may want to consider rolling it out for a bit , till I have time to 
fix this ..


Daniel

