Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVCSQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVCSQcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVCSQcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:32:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:38881 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262635AbVCSQcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:32:39 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: Fix agp_backend usage in drm_agp_init (was: 2.6.11-mm3 - DRM/i915 broken)
Date: Sat, 19 Mar 2005 08:32:03 -0800
User-Agent: KMail/1.8
Cc: Dave Airlie <airlied@gmail.com>, Mike Werner <werner@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, m4rkusxxl@web.de
References: <20050312034222.12a264c4.akpm@osdl.org> <200503181940.54252.jbarnes@sgi.com> <200503181948.34706.jbarnes@sgi.com>
In-Reply-To: <200503181948.34706.jbarnes@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503190832.03783.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 18, 2005 7:48 pm, Jesse Barnes wrote:
> On Friday, March 18, 2005 7:40 pm, Jesse Barnes wrote:
> > What does your patch look like?  Markus might like to try it out as he
> > narrowed his problem down to something AGP related recently too:
> > http://bugme.osdl.org/show_bug.cgi?id=4337
>
> duh, ignore me.  At least Markus can give it a try.

Oh well, Brice's patch didn't work for Marcus (symptoms were different anyway 
so it was a long shot).  I really have to find an AGP machine with a single 
pipe to test this stuff on...

Jesse
