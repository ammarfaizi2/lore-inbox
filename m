Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283650AbRK3M7e>; Fri, 30 Nov 2001 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283649AbRK3M7Y>; Fri, 30 Nov 2001 07:59:24 -0500
Received: from 10fwd.cistron-office.nl ([195.64.65.197]:32780 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S283651AbRK3M7J>; Fri, 30 Nov 2001 07:59:09 -0500
Date: Fri, 30 Nov 2001 13:59:06 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: XT-PIC vs IO-APIC and PCI devices
Message-ID: <20011130135906.A4850@cistron.nl>
Reply-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111301241410.4564-100000@netfinity.realnet.co.sz> <Pine.LNX.4.33.0111301443190.23494-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111301443190.23494-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Fri, Nov 30, 2001 at 02:49:41PM +0200
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Zwane Mwaikambo:
> It shows up as level-triggered.
> 
> 22:          0          0   IO-APIC-level  pentanet0 <==

OK. If it showed up as edge I would know what was wrong, but
level is correct.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.
