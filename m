Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUDJMTm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDJMTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 08:19:42 -0400
Received: from viefep16-int.chello.at ([213.46.255.17]:15129 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id S262008AbUDJMTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 08:19:41 -0400
Date: Sat, 10 Apr 2004 14:21:46 +0200
From: Dub Spencer <dub@lazy.shacknet.nu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linuxbugs@nvidia.com
Subject: Re: 2.6.5 hangs when burning cdrom while watching tv
Message-ID: <20040410122146.GA2427@lazy.shacknet.nu>
References: <20040410105136.GA2177@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410105136.GA2177@lazy.shacknet.nu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 12:51:36PM +0200, Dub Spencer wrote:
> hello,
> 
> when motv is running (bttv module, overlay mode) and then burning a cd
> at higher speeds, the system stops: ie. shift led on keyboard no longer
> lights.  when burning at lower speeds (10x for cdrw) the system only
> hung, when starting mozilla firebird (aka heavy application).

tried the same with xfree (4.3) "nv" driver, no dri, no nvidia module
loaded, and can no longer reproduce. excuse the noise. nvidia's turn.

dub
