Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVE3Wkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVE3Wkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVE3Wkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:40:31 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:9739 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261800AbVE3WkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:40:14 -0400
Date: Mon, 30 May 2005 15:45:04 -0700
To: Karim Yaghmour <karim@opersys.com>, h@nietzsche.lynx.com
Cc: Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
Message-ID: <20050530224504.GD9972@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10505302040560.31148-100000@da410.phys.au.dk> <429B6D14.2070206@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B6D14.2070206@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 03:44:20PM -0400, Karim Yaghmour wrote:
> Esben Nielsen wrote:
> > very close to nil. (Please, prove me wrong if you have a RT IP-stack
> > and maybe a RT USB stack for RTAI.)
> 
> Do take me seriously when I say that RTAI is seriously overlooked:
> 
> RT-Net (real-time UDP over Ethernet):
> http://www.rts.uni-hannover.de/rtnet/
> 
> RT-USB (real-time USB):
> https://mail.rtai.org/pipermail/rtai/2005-April/011192.html
> http://developer.berlios.de/projects/rtusb
> 
> Both of these use RTAI on top of Adeos :P

I've always like your project and the track that it has taken with the
above along with the scheduler work. I am surprised that more folks don't
use it, but I think that has to do with the sucky web site and inability
for me and others to navigate through it for proper information.

bill

