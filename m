Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWERGNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWERGNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 02:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWERGNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 02:13:32 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:14215 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750796AbWERGNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 02:13:32 -0400
Message-ID: <446C10B0.6060602@sbcglobal.net>
Date: Thu, 18 May 2006 01:14:08 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vgoyal@in.ibm.com, galak@kernel.crashing.org, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
References: <20060505172847.GC6450@in.ibm.com>	<2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org>	<20060509200301.GA15891@in.ibm.com>	<446C03F4.20508@sbcglobal.net> <20060517224334.7d2bb5eb.akpm@osdl.org>
In-Reply-To: <20060517224334.7d2bb5eb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matthew Frost <artusemrys@sbcglobal.net> wrote:
>> This may sound like a dumb question, but aside from code bloat, what are 
>>  the performance issues involved in running 64-bit resources on 32-bit 
>>  systems?
> 
> Unmeasurably minor, I expect.

Noted, with thanks.

> 
> No sane software project would take on this (small) maintenance burden just
> to save 50-60 kbytes.  We would though.

I'm aware of that, and I'm not complaining.  :)  It's one of the things 
I love about this project.  It's a healthy insanity, enforced by the 
squeaking of the wheels.  Besides, code bloat is cumulative.

Matt
