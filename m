Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbSLLBBZ>; Wed, 11 Dec 2002 20:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbSLLBBZ>; Wed, 11 Dec 2002 20:01:25 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:47038 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267397AbSLLBBY>; Wed, 11 Dec 2002 20:01:24 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dave Jones <davej@codemonkey.org.uk>
Date: Thu, 12 Dec 2002 12:09:02 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021212010902.GB31961@cse.unsw.edu.au>
References: <20021211172559.GA8613@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211172559.GA8613@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Threading improvements.
> ~~~~~~~~~~~~~~~~~~~~~~~
> - Ingo Molnar put a lot of work into threading improvements during 2.5.
>   Some of the features of this work are:

>   -  sys_clone() enhancements (CLONE_SETTLS, CLONE_SETTID, CLONE_CLEARTID,
>      CLONE_DETACHED)

The middle two enhancements actually turned into three:
CLONE_PARENT_SETTID, CLONE_CHILD_SETTID and CLONE_CHILD_CLEARTID since
~2.5.47 or so, just for reference.

-i
ianw@gelato.unsw.edu.au


