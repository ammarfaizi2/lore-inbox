Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275300AbRIZQ3i>; Wed, 26 Sep 2001 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275298AbRIZQ33>; Wed, 26 Sep 2001 12:29:29 -0400
Received: from cs666814-197.austin.rr.com ([66.68.14.197]:19186 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S275306AbRIZQ3X>; Wed, 26 Sep 2001 12:29:23 -0400
Date: Wed, 26 Sep 2001 11:29:34 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: Tim Connors <tcon@Physics.usyd.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM bug in 2.4.10-pre15 (been there a while though)
In-Reply-To: <Pine.SOL.3.96.1010926193716.15516A-100000@suphys.physics.usyd.edu.au>
Message-ID: <Pine.LNX.4.33.0109261128250.4429-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, but I did do a make menuconfig and save it, without actually making any
changes to the config.

Evan

-- 
| Evan Harris - Consultant, Harris Enterprises - eharris@puremagic.com
|
| Custom Solutions for your Software, Networking, and Telephony Needs

On Wed, 26 Sep 2001, Tim Connors wrote:

> > After that, the system locks up tight.  The .config was copied verbatim with
> > no changes from my working 2.4.3 config, but when I tested 2.4.8 and 2.4.9,
> > they had similar crashes right after booting.  Was unable to test kernels
> > 2.4.4-2.4.7 because of various modules I use having compile errors.
>
> I don't know whether this is related - but you didn't go
> make oldconfig?
>
> You'll need to do that first before make dep in order to use the old
> .config file.
>
> --
> TimC -- http://www.physics.usyd.edu.au/~tcon/
>
> Some witty text here,
> can be any number of lines
> long
>

