Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293212AbSBWWAd>; Sat, 23 Feb 2002 17:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293224AbSBWWAY>; Sat, 23 Feb 2002 17:00:24 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:7949 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S293212AbSBWWAI>;
	Sat, 23 Feb 2002 17:00:08 -0500
Date: Sat, 23 Feb 2002 22:00:04 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223220004.GA49114@compsoc.man.ac.uk>
In-Reply-To: <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <20020223043815.B29874@hq.fsmlabs.com> <1014488408.846.806.camel@phantasy> <20020223120648.A1295@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020223120648.A1295@hq.fsmlabs.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 12:06:48PM -0700, yodaiken@fsmlabs.com wrote:

> With preemption this turns into a problem that is easier to solve
> with a lock or by not having per-cpu caches in the first place -- 

whilst you're correct (pre-emption has made everything harder), there's
not much point moaning about it, since it's in linus' kernel now. So 
why bother ?

regards
john

-- 
"Oh dear, more knobs."
	- David Chase
