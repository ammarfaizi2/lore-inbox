Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbUDQTBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbUDQTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:01:11 -0400
Received: from florence.buici.com ([206.124.142.26]:6543 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264023AbUDQTBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:01:08 -0400
Date: Sat, 17 Apr 2004 12:01:07 -0700
From: Marc Singer <elf@buici.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040417190107.GA4179@flea>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <1082228313.2580.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082228313.2580.25.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 11:58:33AM -0700, Trond Myklebust wrote:
> > I'd be glad to compare TCP to UDP on my system.  It's using an nfsroot
> > mount.  It looks like the support is there.  What activates it?
> 
> It's all there. Just use the "tcp" mount option.

I think you are talking about the fstab mount option.  Is there a
kernel command line option for this?  That's what I've been looking
for.  I'm not using an initrd.

Cheers.
