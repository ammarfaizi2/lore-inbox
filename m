Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVDBPTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVDBPTA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 10:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDBPTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 10:19:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31150 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261547AbVDBPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 10:18:58 -0500
Date: Sat, 2 Apr 2005 09:18:45 -0600 (CST)
From: Bruce Losure <blosure@sgi.com>
To: Paul Jackson <pj@engr.sgi.com>
cc: Andrew Morton <akpm@osdl.org>, <blosure@sgi.com>,
       <mochel@digitalimplant.org>, <linux-kernel@vger.kernel.org>
Subject: Re: new SGI TIOCX driver in *-mm driver model locking broken
In-Reply-To: <20050402041449.352b99da.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0504020916490.28924-100000@fsgi025.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I booted a kernel with the patch on my system and it works as expected.
Thanks!

-Bruce

On Sat, 2 Apr 2005, Paul Jackson wrote:

> Andrew wrote:
> > Pat did a patch, but nobody's tested it yet.
> 
> It compiles.  I have idea how to test it any further.
> 
> 

-- 
Bruce Losure                            internet: blosure@sgi.com
SGI                                     phone:    +1 651 683-7263
2750 Blue Water Rd			vnet:	  233-7263
Eagan, MN, USA 55121

