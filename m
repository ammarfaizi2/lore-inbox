Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbRFJXVH>; Sun, 10 Jun 2001 19:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263172AbRFJXU4>; Sun, 10 Jun 2001 19:20:56 -0400
Received: from HSE-Toronto-ppp91066.sympatico.ca ([216.209.41.31]:18560 "EHLO
	dmz.remoteserver.org") by vger.kernel.org with ESMTP
	id <S263170AbRFJXUj>; Sun, 10 Jun 2001 19:20:39 -0400
Date: Sun, 10 Jun 2001 19:19:57 -0400 (EDT)
From: Daniel Rose <joe@datalinesolutions.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: pppd in 2.4 series
In-Reply-To: <Pine.LNX.4.10.10106102240590.23532-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.21.0106101919070.29055-100000@dmz.remoteserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2001, Mark Hahn wrote:

> > Everything compiles fine, and boots fine, but try and run pppd, and "This
> > kernel as no support of PPP.."
> 
> normally a sign that user-space and kernel versions have diverged.
> 
It was indeed a conflict w/ the ppp version i had installed. Upgraded to
2.4.1 and all is well.

