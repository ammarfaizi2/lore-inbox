Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUACNKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 08:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUACNKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 08:10:36 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:53777 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262033AbUACNKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 08:10:35 -0500
Date: Sat, 3 Jan 2004 14:10:29 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040103141029.B3393@pclin040.win.tue.nl>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>; from torvalds@osdl.org on Fri, Jan 02, 2004 at 08:46:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 08:46:33PM -0800, Linus Torvalds wrote:

> > Random cookies? I prefer "arbitrary" over "random". The value plays no role
> > at all, but it must be unique, preferably stable across reboots.
> 
> The operative word in "preferably stable across reboots" is
> "preferably". Because it basically cannot be in the general case,
> and thus nothing must ever _assume_ it is.

Sure. It is not "need". It is "quality of implementation".
Consider NFS.

Andries

