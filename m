Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbTCJJWt>; Mon, 10 Mar 2003 04:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbTCJJWt>; Mon, 10 Mar 2003 04:22:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:7155 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261242AbTCJJWt>;
	Mon, 10 Mar 2003 04:22:49 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Mar 2003 10:32:57 +0100 (MET)
Message-Id: <UTC200303100932.h2A9WvN26579.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, viro@math.psu.edu
Subject: Re: Fwd: struct inode size reduction.
Cc: davej@codemonkey.org.uk, hch@infradead.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the previous letter was the constructive part.
The destructive part was the deletion of i_cdev
and related code since it does not do anything today.

Comments?

Andries
