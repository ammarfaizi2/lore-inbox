Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUBJS6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUBJS6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:58:10 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59401 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266310AbUBJS6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:58:08 -0500
Date: Tue, 10 Feb 2004 19:57:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Fester <Andreas.Fester@gmx.de>
cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [2.6 PATCH] persist qconf options
In-Reply-To: <4028895C.4010101@gmx.de>
Message-ID: <Pine.LNX.4.58.0402101952100.7851@serv>
References: <4028075E.1070809@gmx.de> <Pine.LNX.4.58.0402100050230.7851@serv>
 <4028895C.4010101@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 10 Feb 2004, Andreas Fester wrote:

> > All these access functions are really not neccessary.
>
> Well, I think in the sense of an Object Oriented interface
> with getter/setter methods they probably *do* make sense ...

They have the tendency to bloat the source and I try to keep it small.

> > Bonus points if you also save the list mode and the position of the
> > splitter. :)
>
> Lets see if I can win them :-)

Great, I'm looking forward to it.
Thanks.

bye, Roman
