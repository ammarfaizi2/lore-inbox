Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWHRWwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWHRWwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWHRWwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:52:20 -0400
Received: from mother.openwall.net ([195.42.179.200]:55483 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751565AbWHRWwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:52:19 -0400
Date: Sat, 19 Aug 2006 02:48:14 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818224814.GA10524@openwall.com>
References: <20060816223633.GA3421@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816223633.GA3421@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Wed, Aug 16, 2006 at 10:36:33PM +0000, Willy Tarreau wrote:
> Also, I've been asked by several people to consider merging Mikael
> Pettersson's gcc4 patches :
> 
>    http://user.it.uu.se/~mikpe/linux/patches/2.4/
> 
> I've been reluctant at first for the usual reasons : "who has a 2.4
> distro with gcc4 ?" ...

We're about to migrate Openwall GNU/*/Linux (Owl) from its current gcc
3.4.5 (which we used in our 2.0 release) to gcc 4+ - and we'd rather
_not_ migrate to Linux 2.6 at the same time, if we can.  We'd be more
comfortable migrating to Linux 2.6 a few months later.
   
So your intent to add gcc 4+ support into Linux 2.4 is very welcome!

-- 
Alexander Peslyak <solar at openwall.com>
GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
http://www.openwall.com - bringing security into open computing environments
