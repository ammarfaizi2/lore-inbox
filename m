Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUACXIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUACXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 18:08:47 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:15112 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264272AbUACXIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 18:08:46 -0500
Date: Sun, 4 Jan 2004 00:08:40 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104000840.A3625@pclin040.win.tue.nl>
References: <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>; from torvalds@osdl.org on Sat, Jan 03, 2004 at 02:27:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 02:27:47PM -0800, Linus Torvalds wrote:

> > Sure. It is not "need". It is "quality of implementation".
> > Consider NFS.

> And then a high-quality implementation actually ends up being 
> _detrimental_. It's hiding problems that can still happen, they just 
> happen rarely enough that the bugs don't get found and fixed.

Empty talk. This is not about finding and fixing bugs.
We know very precisely what properties the NFS protocol has.
Now one can have a system that works as well as possible with NFS.
And one can have a worse system.

Andries

