Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279399AbRJ2Tgq>; Mon, 29 Oct 2001 14:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279414AbRJ2Tgm>; Mon, 29 Oct 2001 14:36:42 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:4718 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S279399AbRJ2TgL>; Mon, 29 Oct 2001 14:36:11 -0500
Date: Mon, 29 Oct 2001 19:30:17 +0000
From: Adrian Burgess <kernel@corrosive.freeserve.co.uk>
To: Justin Mierta <Crazed_Cowboy@stones.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ECS k7s5a motherboard doesnt work
Message-ID: <20011029193017.A7083@corrosive.freeserve.co.uk>
Mail-Followup-To: Justin Mierta <Crazed_Cowboy@stones.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15y9q4-0002ER-00@the-village.bc.nu> <3BDD7164.8080401@stones.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDD7164.8080401@stones.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.13-ac2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 10:10:28AM -0500, Justin Mierta wrote:
> 
> well, i dont have a floppy drive, so that test is a little difficult to 
> do, but i threw some ram in there that i have used in linux before, and 
> i still had the slew of ide error messages.  and this harddrive has 
> worked in linux before.  i'm getting more and more convinced its an ide 
> controller +linux issue.
> 
> plus, i just discovered this:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0198.html
> 
> which really points to ide controller and linux not fighting nicely 
> together, altho the thread doesnt really point towards a solution.
> 
> justin

Ok, well, I'm still using the KS75A under Linux, Win98, and WinXP, and the
only OS that seems to have problems is Linux.  I don't have any data
corruption problems (as far as I know), but I'm still getting the DMA
timeout errors reported in the thread above.  There definitely seems to be
more reports than normal about IDE problems with Linux on this board.  And
other than IDE the board seems pretty stable.
Btw, the SIS900 is the on-board Ethernet controller.

Cheers,
Adrian
