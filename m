Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSCPSgZ>; Sat, 16 Mar 2002 13:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSCPSgF>; Sat, 16 Mar 2002 13:36:05 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:18441 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291745AbSCPSf6>;
	Sat, 16 Mar 2002 13:35:58 -0500
Date: Sat, 16 Mar 2002 11:35:36 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316113536.A19495@hq.fsmlabs.com>
In-Reply-To: <15507.12988.581489.554212@argo.ozlabs.ibm.com> <Pine.LNX.4.33.0203160953420.31850-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0203160953420.31850-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 16, 2002 at 10:06:06AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 10:06:06AM -0800, Linus Torvalds wrote:
> We'll end up (probably five years from now) re-doing the thing to allow 
> four levels (so a tired old x86 would fold _two_ levels instead of just 
> one, but I bet they'll still be the majority), simply because with three 
> levels you reasonably reach only about 41 bits of VM space.

Why so few bits per level? Don't you want bigger pages or page clusters?


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

