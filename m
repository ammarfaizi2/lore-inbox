Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRLYAdZ>; Mon, 24 Dec 2001 19:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284111AbRLYAdP>; Mon, 24 Dec 2001 19:33:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24011 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284088AbRLYAdG>; Mon, 24 Dec 2001 19:33:06 -0500
Date: Mon, 24 Dec 2001 16:29:23 -0800
From: Russ Weight <rweight@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: bitops.h
Message-ID: <20011224162922.A11751@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick question: I see that there is support for both zero- and
one-based bitmasks (e.g. ffs() vs. ffz()). Are there technical
reasons to prefer one over the other? Or is this just a matter
of preference, or whatever lends itself best to the task at
hand? (It seems as though I have seen some reference to this
prevously, but I am unable to find anything in the archives.)

- Russ


-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
