Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUKWSUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUKWSUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKWSSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:18:10 -0500
Received: from lucidpixels.com ([66.45.37.187]:23456 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261464AbUKWSQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:16:15 -0500
Date: Tue, 23 Nov 2004 13:16:14 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Drivers For Multi-Port Nic Question
In-Reply-To: <41A37AF0.3000207@candelatech.com>
Message-ID: <Pine.LNX.4.61.0411231315470.3740@p500>
References: <Pine.LNX.4.61.0411230822170.3740@p500> <41A37AF0.3000207@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The manufacturer and model of this ethernet card is:

An Adaptec ANA-6944A/TX NIC 10/100 Quad-port Ethernet Card.

On Tue, 23 Nov 2004, Ben Greear wrote:

> Justin Piszcz wrote:
>> Does it matter what driver I use for a tulip-based board?
>> It is tulip based, but two drivers seem to work for it.
>
> What is the manufacturer and model of this ethernet card?
>
> Usually, the tulip is the best driver....
>
> Ben
>
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
