Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264046AbRFKJqz>; Mon, 11 Jun 2001 05:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264051AbRFKJqp>; Mon, 11 Jun 2001 05:46:45 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:24116 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264047AbRFKJql>; Mon, 11 Jun 2001 05:46:41 -0400
Date: Mon, 11 Jun 2001 09:45:50 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Lucca <lucca@shogun1.csun.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process table fills with DN state when nfs connection is lost
Message-ID: <20010611094550.A15813@grobbebol.xs4all.nl>
In-Reply-To: <20010610223428.A27096@grobbebol.xs4all.nl> <Pine.LNX.4.21.0106101841010.1555-100000@shogun1.csun.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0106101841010.1555-100000@shogun1.csun.edu>; from lucca@shogun1.csun.edu on Sun, Jun 10, 2001 at 06:44:56PM -0700
X-OS: Linux grobbebol 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 06:44:56PM -0700, Lucca wrote:
> Not incorrect, but you might experiment with soft mounts, which will rapidly
> timeout and die with io-errors rather than hanging.

Gombas also replied with such information.

I didn't know that this was causing it. I changed the (default hard) to
soft mount and now it doesn't go wrong. best woul dbe to tell my
girlfriend not to reboot while nfs is active though :-)

Thanks anyways.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
