Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTE0PjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTE0PjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:39:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:60358 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263918AbTE0PjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:39:16 -0400
Date: Tue, 27 May 2003 08:52:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <13800000.1054050738@[10.10.2.4]>
In-Reply-To: <6ullwso0wj.fsf@zork.zork.net>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com><200305271048.36495.devilkin-lkml@blindguardian.org><20030527130515.GH8978@holomorphy.com><200305271729.49047.devilkin-lkml@blindguardian.org> <6ullwso0wj.fsf@zork.zork.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> DevilKin-LKML <devilkin-lkml@blindguardian.org> writes:
> 
>> On Tuesday 27 May 2003 15:05, William Lee Irwin III wrote:
>>> I suspect you're attempting to shoot yourself in the foot. .config?
>> 
>> Ah, quite. I saw NUMA was activated, and disabling it fixed my
>> problem. Odd though, that it should become active just by doing a
>> 'make oldconfig' with my 2.7.69 config file...
> 
> I guess in the future, all boxes are NUMA.

However, in the future, all boxes are also not i386, so we're OK still ;-)

M.

