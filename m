Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSLOWaG>; Sun, 15 Dec 2002 17:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSLOWaG>; Sun, 15 Dec 2002 17:30:06 -0500
Received: from holomorphy.com ([66.224.33.161]:64431 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263143AbSLOWaF>;
	Sun, 15 Dec 2002 17:30:05 -0500
Date: Sun, 15 Dec 2002 14:37:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mike Hayward <hayward@loup.net>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021215223703.GA2690@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Mike Hayward <hayward@loup.net>,
	linux-kernel@vger.kernel.org
References: <200212090830.gB98USW05593@flux.loup.net> <20021213154544.GK9882@holomorphy.com> <20021215215951.GA6347@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021215215951.GA6347@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> This is the same for me. I'm extremely uninterested in the P-IV for my
>> own use because of this.

On Sun, Dec 15, 2002 at 10:59:51PM +0100, Pavel Machek wrote:
> Well, then you should fix the kernel so that syscalls are done by
> sysenter (or how is it called).
> 								Pavel

ABI is immutable. I actually run apps at home.

sysenter is also unusable for low-level loss-of-state reasons mentioned
elsewhere in this thread.


Nice try, though.


Bill
