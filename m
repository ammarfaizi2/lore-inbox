Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUIAMeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUIAMeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIAMeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:34:08 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:13542 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266308AbUIAMcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:32:10 -0400
Message-ID: <4699bb7b04090105323c2d69b8@mail.gmail.com>
Date: Thu, 2 Sep 2004 00:32:09 +1200
From: Oliver Hunt <oliverhunt@gmail.com>
Reply-To: Oliver Hunt <oliverhunt@gmail.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Time runs exactly three times too fast
Cc: Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409010826500.4481@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409021453.09730.aero_climb@yahoo.fr>
 <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
 <4699bb7b04090105182c5591a9@mail.gmail.com> <Pine.LNX.4.58.0409010826500.4481@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 08:28:02 -0400 (EDT), Zwane Mwaikambo
<zwane@linuxpower.ca> wrote:
> On Thu, 2 Sep 2004, Oliver Hunt wrote:
> 
> > Is it just me or the bogomips rating listed there completely out of whack?
> 
> Yes it is, you'll also note that the cpu clock frequency is also low,
> hence my suspicion of cpufreq, which would affect general timing.
> 

Oops, I hadn't noticed that :)

Perhaps one of the cpu specific options in the config? 
Sadly I can't remember what options there are, and the last 2.6 kernel
compile I did was with 2.6.3 or 4 so there may be new options, but I
can't think of anything that could conceivably cause weirdness in the
clock speed detection...

--Oliver
