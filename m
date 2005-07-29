Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVG2OvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVG2OvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVG2OvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:51:15 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39940 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262606AbVG2OvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:51:13 -0400
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, mpm@selenic.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, akpm@osdl.org, chrisw@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
References: <20050729083850.GB7302@elte.hu> <5482.1122633728@www71.gmx.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: you'll understand when you're older, dear.
Date: Fri, 29 Jul 2005 15:50:13 +0100
In-Reply-To: <5482.1122633728@www71.gmx.net> (Michael Kerrisk's message of
 "29 Jul 2005 11:44:30 +0100")
Message-ID: <87u0idhdju.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2005, Michael Kerrisk stated:
> Yes, as noted in my earlier message -- at the moment RLIMIT_NICE 
> still isn't in the current glibc snapshot...

According to traffic on libc-hacker, Ulrich committed it on Jun 20
(along with RLIMIT_RTPRIO support).

-- 
`Tor employs several thousand editors who they keep in dank
 subterranean editing facilities not unlike Moria' -- James Nicoll 
