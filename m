Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288188AbSANI0a>; Mon, 14 Jan 2002 03:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSANI0L>; Mon, 14 Jan 2002 03:26:11 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:31635 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288188AbSANIZ7>;
	Mon, 14 Jan 2002 03:25:59 -0500
Date: Mon, 14 Jan 2002 08:24:45 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114082444.GA24931@fenrus.demon.nl>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl> <E16PzHb-00006g-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PzHb-00006g-00@starship.berlin>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:03:43AM +0100, Daniel Phillips wrote:
> Sorry, that's incorrect.  I stated why earlier in this thread and akpm signed 
> off on it.  With preempt you get ASAP (i.e., as soon as the outermost 
> spinlock is done) process scheduling.  With hand-coded scheduling points you 
> get 'as soon as it happens to hit a scheduling point'.
> 
> That is not the only benefit, just the most obvious one.

Big duh. So you get there 1 usec sooner. NOBODY will notice that. NOBODY.
