Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTKKSWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTKKSWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:22:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18347 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263691AbTKKSWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:22:48 -0500
Date: Tue, 11 Nov 2003 18:22:45 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <20031111182245.GB24159@parcelfarce.linux.theplanet.co.uk>
References: <Pine.SGI.4.53.0311111116440.360387@subway.americas.sgi.com> <Pine.LNX.4.44.0311111007350.30657-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311111007350.30657-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 10:17:47AM -0800, Linus Torvalds wrote:

> Al - do we have some good documentation of how to use the seq-file 
> interface? 

There was a text on LWN and it's OK for starting point.  I'll try to
put together something compact, but somebody will have to go through
the result and turn it into proper English...
