Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVCVP5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVCVP5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCVP5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:57:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:17303 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261386AbVCVP5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:57:20 -0500
Date: Tue, 22 Mar 2005 16:59:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org,
       Phillip Lougher <phillip@lougher.demon.co.uk>
Subject: Re: Squashfs without ./..
In-Reply-To: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Jan Engelhardt wrote:

> Hello,
> 
> 
> I have observed that squashfs, when mounted, does not return any "." or ".." 
> pseudo-directories upon readdir.
> Could this be added? Would there be any objections?
> 
I can't say if there will be any objections or not, but if that's 
something that people want, then I'd like to take a stab at implementing 
it - could be fun and I'd love to learn a little more about that are of 
the kernel, so I'll have a go at it if noone screams.

/Jesper Juhl

