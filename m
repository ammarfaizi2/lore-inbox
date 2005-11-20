Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKTDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKTDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVKTDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:01:09 -0500
Received: from dsl093-119-032.blt1.dsl.speakeasy.net ([66.93.119.32]:22966
	"EHLO bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S1751170AbVKTDBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:01:08 -0500
Date: Sat, 19 Nov 2005 22:00:59 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Bharath Ramesh <krosswindz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intel8x0 sound of silence on dell system
In-Reply-To: <20051118181945.GB22566@kvack.org>
Message-ID: <Pine.LNX.4.63.0511192200030.16530@bushido>
References: <20051118162300.GA22092@kvack.org>
 <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com>
 <20051118180410.GA22566@kvack.org> <Pine.LNX.4.63.0511181310410.23989@bushido>
 <20051118181945.GB22566@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (bushido.realityfailure.org [10.0.0.10]); Sat, 19 Nov 2005 22:01:00 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Benjamin LaHaise wrote:

> On Fri, Nov 18, 2005 at 01:11:52PM -0500, John Jasen wrote:
>> You can try adding buggy_irq=1, buggy_semaphore=1 or both to your
>> modprobe.conf file, and see if any of those help. It did in my case.
>
> Doesn't seem to have an effect here.

any dmesg or /var/log/messages output?

lspci output of the card?

entry from modprobe.conf?

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- No one will sorrow for me when I die, because those who would
-- are dead already. -- Lan Mandragoran, The Wheel of Time, New Spring
