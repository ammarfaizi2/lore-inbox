Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbWAJWzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbWAJWzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbWAJWzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:55:07 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39605 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030623AbWAJWzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:55:06 -0500
Date: Tue, 10 Jan 2006 17:54:47 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Message-ID: <20060110225447.GA13709@filer.fsl.cs.sunysb.edu>
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr> <20060110202920.GA5479@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0601102143530.16049@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601102143530.16049@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:44:43PM +0100, Jan Engelhardt wrote:
> 
> >> I doubt this scrollback buffer is implemented as part of the video cards. 
> >> It is rather a kernel invention, and therefore uses standard RAM. But the 
> >> idea is good, preferably make it a CONFIG_ option.
> >
> >There is a config option that lets you specify the size of this buffer:
> >CONFIG_LOG_BUF_SHIFT
> 
> menuconfig help says
> 
>     "Select kernel log buffer size as a power of 2."
> 
> That does not sound like "console scroll buffer".

True. I should think more about what I say before I say it.

Jeff.
