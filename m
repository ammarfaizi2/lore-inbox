Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSIIAOq>; Sun, 8 Sep 2002 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSIIAOq>; Sun, 8 Sep 2002 20:14:46 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:38530 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S315709AbSIIAOp>; Sun, 8 Sep 2002 20:14:45 -0400
Date: Sun, 8 Sep 2002 17:19:27 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Tabris <tabris@tabris.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: opps 2.4.20-pre5-ac2
Message-ID: <20020909001927.GA12608@the-penguin.otak.com>
References: <20020908203126.GA11475@the-penguin.otak.com> <200209081753.14660.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209081753.14660.tabris@tabris.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-pre5-ac2 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tabris [tabris@tabris.net] wrote:
> This is an interaction of the rmap vm patch (included in -ac) and the nVidia 
> binary driver. I have run into this myself, tho it doesn't usually cause a 
> lockup for me. (instead, it puts kswapd in the Z state (it aparrently never 
> respawns), and makes shutting down a PITA.))
> 
> Mind you, this is a bug in the nVidia driver, not the linux kernel, where it 
> pulls a behaviour that never was really correct before, but did work. This 
> bug truly needs to be reported to nVidia.

I am not using nvidia anything.

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


