Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbUDQScX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbUDQScX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:32:23 -0400
Received: from florence.buici.com ([206.124.142.26]:1167 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264016AbUDQScU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:32:20 -0400
Date: Sat, 17 Apr 2004 11:32:19 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040417183219.GB3856@flea>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082225747.2580.18.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 11:15:47AM -0700, Trond Myklebust wrote:
> This sort of issue is precisely why I'd prefer to see people use TCP by
> default. UDP with it's dependency on fragmentation works fine on fast
> setups with homogeneous lossless networks. It sucks as soon as you break
> one of those conditions.

I'd be glad to compare TCP to UDP on my system.  It's using an nfsroot
mount.  It looks like the support is there.  What activates it?
 
