Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTHUAiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbTHUAip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:38:45 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:32516 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262353AbTHUAio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:38:44 -0400
Date: Thu, 21 Aug 2003 02:38:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6 -- gnome problem
Message-ID: <20030821023836.B3204@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no> <20030820215246.B3065@pclin040.win.tue.nl> <3F441213.4060906@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F441213.4060906@tupshin.com>; from tupshin@tupshin.com on Wed, Aug 20, 2003 at 05:28:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 05:28:03PM -0700, Tupshin Harper wrote:

> This patch makes the previously posted test work for me, but I'm 
> experiencing a differenct NFS regression between 2.4 and 2.6. Whatever 
> locking method that gnome2 is using when running home directories over 
> nfs is failing when the client is running 2.6.
> Gnome reports that it failed to lock it's test file, and aborts.
> It says that the error was "no locks available".

"Gnome" is not precise enough for me.
If you have an explicit test program that works on 2.4 and fails
on 2.6 and is not more than a single page in length, I wouldnt mind
looking at it.

