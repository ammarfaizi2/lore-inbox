Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293243AbSBWWpx>; Sat, 23 Feb 2002 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293246AbSBWWpf>; Sat, 23 Feb 2002 17:45:35 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:52239 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293166AbSBWWpT>;
	Sat, 23 Feb 2002 17:45:19 -0500
Date: Sat, 23 Feb 2002 15:43:55 -0700
From: yodaiken@fsmlabs.com
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223154355.A4058@hq.fsmlabs.com>
In-Reply-To: <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com> <20020223220004.GA49114@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020223220004.GA49114@compsoc.man.ac.uk>; from movement@marcelothewonderpenguin.com on Sat, Feb 23, 2002 at 10:00:04PM +0000
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 10:00:04PM +0000, John Levon wrote:
> On Sat, Feb 23, 2002 at 12:06:48PM -0700, yodaiken@fsmlabs.com wrote:
> 
> > With preemption this turns into a problem that is easier to solve
> > with a lock or by not having per-cpu caches in the first place -- 
> 
> whilst you're correct (pre-emption has made everything harder), there's
> not much point moaning about it, since it's in linus' kernel now. So 
> why bother ?
> 

everyone needs a hobby. 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

