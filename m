Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVDVP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVDVP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVDVPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:54:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57849 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S262023AbVDVPxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:53:05 -0400
Date: Fri, 22 Apr 2005 08:53:03 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
In-Reply-To: <20050422154931.GA22534@elte.hu>
Message-ID: <Pine.LNX.4.44.0504220852310.22042-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What command line did you use ?

./test --samples 10000 --hertz 128 --tasks 0


Daniel

On Fri, 22 Apr 2005, Ingo Molnar wrote:

> 
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Is this the PriorityInversionTest (pi_test.tgz) or was there another one?
> 
> yes, it's pi_test.tgz.
> 
> 	Ingo
> 

