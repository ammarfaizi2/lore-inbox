Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUBWQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUBWQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:19:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:64897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbUBWQTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:19:23 -0500
Date: Mon, 23 Feb 2004 08:11:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: martinb@igotu.com
Cc: martinb@www.igotu.com, linux-kernel@vger.kernel.org
Subject: Re: Is LOADLIN still viable for 2.6?
Message-Id: <20040223081138.50f03334.rddunlap@osdl.org>
In-Reply-To: <20040223145740.M2949@www.igotu.com>
References: <20040223145740.M2949@www.igotu.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 10:05:58 -0500 "Martin Bogomolni" <martinb@www.igotu.com> wrote:

| 
| 
| When trying to load a 2.6 kernel from a FreeDOS environment, I am now very
| consistently unable to load the kernel and an initial ramdisk via LOADLIN.  
| 
| The nature of the embedded system I'm working with, requires that DOS be
| present prior to loading linux during an interactive startup and hardware
| intialization phase.  
| 
| Since it doesn't seem that Hans Lermen has been updating or maintaining
| loadlin since the release of 2.4 is there anyone who is continuing to maintain
| LOADLIN, or has it fallen by the wayside?   Due to the nature of the system,
| and a requirement for backwards compatibility and user interaction during
| startup, I cannot use Peter Anvin's SYSLINUX linux loader which occurs too
| early on in the process.
| 
| Are there any other options to startup a linux environment from DOS?

I don't know anything about it, but you might look at gujin:
  http://sourceforge.net/projects/gujin/

--
~Randy
