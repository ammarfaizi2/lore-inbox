Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSH1Sr4>; Wed, 28 Aug 2002 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSH1Sr4>; Wed, 28 Aug 2002 14:47:56 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:21167 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318894AbSH1Sr4>;
	Wed, 28 Aug 2002 14:47:56 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 28 Aug 2002 12:48:39 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828124839.F5492@host110.fsmlabs.com>
References: <20020828134600.A19189@brodo.de> <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0208281140030.4507-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 11:47:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's even worse for some of the very new P4's that don't have their
heatsink seated properly.  They heat up every few minutes and then throttle
themselves due to thermal overload.  I think this situation is going to
become more and more common, now.  We're at the mercy of every BIOS and
micro-code programmer now-a-days.  That situation needs to be improved
upon, as well.

} The interface needs to be improved upon. It is simply _not_ valid to say
} "run at this speed" as the primary policy.
