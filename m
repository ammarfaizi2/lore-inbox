Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTBTN4z>; Thu, 20 Feb 2003 08:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBTN4z>; Thu, 20 Feb 2003 08:56:55 -0500
Received: from almesberger.net ([63.105.73.239]:53008 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265543AbTBTN4z>; Thu, 20 Feb 2003 08:56:55 -0500
Date: Thu, 20 Feb 2003 11:06:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030220110645.Z2092@almesberger.net>
References: <200302201351.FAA08649@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302201351.FAA08649@baldur.yggdrasil.com>; from adam@yggdrasil.com on Thu, Feb 20, 2003 at 05:51:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	Anyhow, my point is that removing a piece of hardware
> does not require that the corresponding module be unloaded
> immediately.

Nor does the use of a module require the presence of any
non-generic hardware in the first place (e.g. net/sched/,
netfilter, PPP, etc.) :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
