Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJ3GDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 01:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTJ3GDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 01:03:54 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:15232
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262188AbTJ3GDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 01:03:53 -0500
Date: Thu, 30 Oct 2003 01:03:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rob Landley <rob@landley.net>
cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk panicked in -test9.
In-Reply-To: <200310292343.04963.rob@landley.net>
Message-ID: <Pine.LNX.4.53.0310300100420.32567@montezuma.fsmlabs.com>
References: <200310291857.40722.rob@landley.net> <200310291935.28554.elenstev@mesatop.com>
 <Pine.LNX.4.53.0310292223190.9199@montezuma.fsmlabs.com>
 <200310292343.04963.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Rob Landley wrote:

> Ah, cool.  Thanks.  (It's now in my init script.)
> 
> Do you know if this affects x's screensaver timeout?  (Probably not, but I'm 
> not sure how to look it up.  Maybe X gets the value from console 7, somehow?  
> Then again, if this was a per-console thing setting it in the initscripts 
> when the console is /dev/console rather than virtual wouldn't necessarily 
> work...  Huh.)

You can set xscreensaver's timeout with xscreensaver-demo.


