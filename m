Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSGXVWL>; Wed, 24 Jul 2002 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSGXVWL>; Wed, 24 Jul 2002 17:22:11 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:60736 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317586AbSGXVWJ>;
	Wed, 24 Jul 2002 17:22:09 -0400
Date: Wed, 24 Jul 2002 23:25:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Kareem Dana <kareemy@earthlink.net>, Andrew Rodland <arodland@noln.com>,
       linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
Message-ID: <20020724212521.GA13196@win.tue.nl>
References: <20020724194130.GB13180@win.tue.nl> <Pine.LNX.3.95.1020724155946.8122A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020724155946.8122A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 04:03:29PM -0400, Richard B. Johnson wrote:

> > Read mount(8), the places where losetup is mentioned.
> 
> It works in my system and `umount` is version 2.10o
> It works because (strace output), umount does the LOOP_CLR_FD ioctl().

Why do you repeat an imprecise answer? Read mount(8).
