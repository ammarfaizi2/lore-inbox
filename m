Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTADETJ>; Fri, 3 Jan 2003 23:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbTADETJ>; Fri, 3 Jan 2003 23:19:09 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:6345 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266702AbTADETH>; Fri, 3 Jan 2003 23:19:07 -0500
Date: Sat, 4 Jan 2003 05:27:36 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] menuconfig support for top-level config menu dependencies
Message-ID: <20030104042736.GQ1360@louise.pinerecords.com>
References: <20030102195024.GC17053@louise.pinerecords.com> <Pine.LNX.4.44.0301032120280.765-100000@spit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301032120280.765-100000@spit.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [zippel@linux-m68k.org]
> 
> Below is a first version, which implements the menuconfig keyword and
> makes use of at two places. The behaviour of 'make config' is still the
> same

That's a good thing, we probably want a few menus look exactly as before.

> but menuconfig and xconfig look a bit different.
> Comments welcome.

Looking good.  Can you please rediff against current 2.5?

-- 
Tomas Szepe <szepe@pinerecords.com>
