Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTEGXto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTEGXtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:49:40 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31366 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264401AbTEGXtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:49:17 -0400
Date: Wed, 07 May 2003 14:47:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Davide Libenzi <davidel@xmailserver.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <19450000.1052344050@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de><Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de><Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]><Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com><Pine.LNX.4.53.0305071424290.13499@chaos> <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, May 07, 2003 11:51:19 -0700 Davide Libenzi <davidel@xmailserver.org> wrote:

> On Wed, 7 May 2003, Richard B. Johnson wrote:
> 
>> No, No. That is a process stack. Every process has it's own, entirely
>> seperate stack. This stack is used only in user mode. The kernel has
>> it's own stack. Every time you switch to kernel mode either by
>> calling the kernel or by a hardware interrupt, the kernel's stack
>> is used.
> 
> Is it your understanding that does not exist a per task kernel stack ?

It seems to be his lack of understanding, more to the point.

M.

