Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbRFUUKV>; Thu, 21 Jun 2001 16:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265188AbRFUUKM>; Thu, 21 Jun 2001 16:10:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:12306 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265179AbRFUUJ5>;
	Thu, 21 Jun 2001 16:09:57 -0400
Date: Thu, 21 Jun 2001 16:13:22 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Message-ID: <20010621161322.A6873@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com> <E15D9DP-0001sF-00@the-village.bc.nu> <20010621151716.B5662@thyrsus.com> <20010621155103.B23465@pimlott.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621155103.B23465@pimlott.ne.mediaone.net>; from andrew@pimlott.ne.mediaone.net on Thu, Jun 21, 2001 at 03:51:03PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott <andrew@pimlott.ne.mediaone.net>:
> On Thu, Jun 21, 2001 at 03:17:16PM -0400, Eric S. Raymond wrote:
> > IANAL, but I believe that Linus's position as anthology copyright holder
> > makes him privileged in this respect.
> 
> Regardless of what you find in the books, recall that Linus has
> stated that decentralizing the copyright of Linux was a goal, so you
> may not find him willing to claim an "anthology copyright" (if such
> a thing even applies to the kernel, which in my NAL opinion, it does
> not).

Linus *is*, however, implicitly claiming the authority to make license
policy on behalf of the other copyright holders in cases where the GPL
is unclear.

In COPYING, Linus says that that the version of GPL applying to the
kernel is v2 unless explicitly otherwise stated.  He has also already
issued the interpretation that normal system calls from userland do
not create a derivation relationship.

I consider Linus to have the moral right to make these decisions, whether
or not the law gives him a formal legal right to do so.  All I have done
is propose that he be more explicit about his policy in order to prevent
needless confusion and nervousness.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The possession of arms by the people is the ultimate warrant
that government governs only with the consent of the governed.
        -- Jeff Snyder
