Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUBTX4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBTX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:56:15 -0500
Received: from gate.in-addr.de ([212.8.193.158]:50839 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261429AbUBTX4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:56:13 -0500
Date: Sat, 21 Feb 2004 00:56:02 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Message-ID: <20040220235602.GD6280@marowsky-bree.de>
References: <20040216190927.GA2969@us.ibm.com> <200402201535.47848.phillips@arcor.de> <20040220211732.A10079@infradead.org> <200402201715.34315.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402201715.34315.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-20T17:16:02,
   Daniel Phillips <phillips@arcor.de> said:

I'm trimming the mm list, because this isn't relevant to them.

> Again, we (everybody who cared to jump in) now agree on what is sane
> here, it's quite logical.  As for supplying background material so
> this makes sense to a wider group of people, sorry it's been on my
> to-do list for a while.  Getting a DFS, namely Sistina GFS, into the
> tree is underway as you know from the press release, however turning
> the ship takes time.  Meanwhile, the api discussion can't wait because
> the rudder on that ship is even smaller.

Surely, such a GFS needs a cluster infrastructure - membership,
messaging, DLM - in the kernel.

Can you or anyone else from Sistina/RHAT clarify on the details of
this?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

