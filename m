Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271011AbRHTC0n>; Sun, 19 Aug 2001 22:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271005AbRHTC0d>; Sun, 19 Aug 2001 22:26:33 -0400
Received: from buzz.sonic.net ([208.201.224.78]:1803 "EHLO buzz.sonic.net")
	by vger.kernel.org with ESMTP id <S271011AbRHTC0X>;
	Sun, 19 Aug 2001 22:26:23 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 19 Aug 2001 19:26:34 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010819192634.H30309@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482526995.998263790@[169.254.45.213]>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 11:29:51PM +0100, Alex Bligh - linux-kernel wrote:
> The machine was bought and tested in one config. A hardware
> random number generator is something else to go wrong, and
> additional expense.


And making a change to the kernel is not a different config?

I would argue that is just as dangerous as changing the hardware
configuration.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
