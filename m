Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274761AbRIZJjB>; Wed, 26 Sep 2001 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274895AbRIZJiw>; Wed, 26 Sep 2001 05:38:52 -0400
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:53173 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S274761AbRIZJig>; Wed, 26 Sep 2001 05:38:36 -0400
Date: Wed, 26 Sep 2001 19:38:45 +1000 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: Evan Harris <eharris@puremagic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM bug in 2.4.10-pre15 (been there a while though)
In-Reply-To: <Pine.LNX.4.33.0109260028030.1071-200000@kinison.puremagic.com>
Message-ID: <Pine.SOL.3.96.1010926193716.15516A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After that, the system locks up tight.  The .config was copied verbatim with
> no changes from my working 2.4.3 config, but when I tested 2.4.8 and 2.4.9,
> they had similar crashes right after booting.  Was unable to test kernels
> 2.4.4-2.4.7 because of various modules I use having compile errors.

I don't know whether this is related - but you didn't go 
make oldconfig?

You'll need to do that first before make dep in order to use the old
.config file.

-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

Some witty text here,
can be any number of lines
long

