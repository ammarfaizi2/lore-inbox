Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279182AbRJWBbP>; Mon, 22 Oct 2001 21:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279185AbRJWBbG>; Mon, 22 Oct 2001 21:31:06 -0400
Received: from virtucon.warpcore.org ([216.81.249.22]:13443 "EHLO virtucon")
	by vger.kernel.org with ESMTP id <S279182AbRJWBa5>;
	Mon, 22 Oct 2001 21:30:57 -0400
Date: Mon, 22 Oct 2001 20:31:59 -0500
From: drevil@warpcore.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011022203159.A20411@virtucon.warpcore.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15vnuN-0003jW-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 11:50:59PM +0100, Alan Cox wrote:
> I can't debug Nvidia's code even to see why it might have broken. Its as
> simple as that - no politics, no agenda on them opening it, simple technical
> statement of fact.

On one side I can see this, on the other I can't. For example, no matter how
many times a user visits windows update, chances are his drivers will still work
with his current version of windows. Admittedly, some may not consider this a
feature, but I think a lot do. Why should a 'stable' kernel series break
existing drivers?

> I really doubt Nvidia will open their driver code. I've heard them explain
> some of the reasons they don't and in part they make complete sense.

Microsoft deals with companies that won't always give them access to the drivers
directly, but often they will tell users workarounds, or at least attempt to
gather enough knowledge since they are tehnically the OS vendor to give to the
driver provider to fix the problem. If you are the OS provider, and a change you
make breaks user drivers/programs generally I think it's a polite gesture to at
least attempt to find out what's going on and then pass that information on to
the people who can properly handle it...
