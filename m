Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTJCIfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTJCIfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:35:44 -0400
Received: from [63.205.85.133] ([63.205.85.133]:13517 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S263605AbTJCIfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:35:43 -0400
Date: Fri, 3 Oct 2003 01:44:22 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andi Kleen <ak@suse.de>
Cc: bvds@bvds.geneva.edu, linux-kernel@vger.kernel.org
Subject: Re: segfault error on x86_64
Message-ID: <20031003084422.GG42593@gaz.sfgoth.com>
References: <20031002215345.A1D33E24D6@bvds.geneva.edu.suse.lists.linux.kernel> <p73y8w2yboa.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y8w2yboa.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > What is "bumps" ?
> 
> Some random program on your system.

Specifically, it's one of the graphics demos that comes with xscreensaver.
If the segfault is reproducible on that arch you might want to report it
to jwz:
  http://www.jwz.org/xscreensaver/

-Mitch
