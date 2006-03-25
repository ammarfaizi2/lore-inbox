Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWCYExq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWCYExq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWCYExq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:53:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11919 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750834AbWCYExp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:53:45 -0500
Date: Fri, 24 Mar 2006 20:53:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: luke.adi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
Message-Id: <20060324205337.d7d81d73.pj@sgi.com>
In-Reply-To: <20060323011718.7f34a282.akpm@osdl.org>
References: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
	<20060322234652.10f6afee.akpm@osdl.org>
	<489ecd0c0603230115h4dd2b16fg54cfd97739a8b339@mail.gmail.com>
	<20060323011718.7f34a282.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   Anyone knows how to avoid "tab to space" converting in gmail?
> 
> If I knew, I'd put it in my .signature :(

If you use sendpatchset:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

with the gmail SMTP server "smtp.gmail.com" you can send patches from
your gmail account without tab destruction.

The documentation for sendpatchset is within the script.  Grep for
'gmail' in the script to see where to hack in your gmail account and
password (low tech configuration ;)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
