Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJCFeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJCFeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVJCFeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:34:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21156 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932092AbVJCFeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:34:07 -0400
Date: Sun, 2 Oct 2005 22:33:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: haveblue@us.ibm.com, magnus@valinux.co.jp, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Message-Id: <20051002223352.6d21a8bc.pj@sgi.com>
In-Reply-To: <aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	<1128093825.6145.26.camel@localhost>
	<20051002202157.7b54253d.pj@sgi.com>
	<aec7e5c30510022205o770b6335o96d9a9d9cc5d7397@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus wrote:
> So, Paul, please let me know if you prefer SMP || NUMA or no
> depencencies in the Kconfig.

In theory, I prefer none.  But the devil is in the details here,
and I really don't care that much.

So pick whichever you prefer, or whichever provides the nicest
looking code or patch, or flip a coin ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
