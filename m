Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVAEK5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVAEK5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVAEK5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:57:47 -0500
Received: from orb.pobox.com ([207.8.226.5]:698 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262320AbVAEK5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:57:46 -0500
Date: Wed, 5 Jan 2005 02:57:31 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, tytso@mit.edu, davidsen@tmr.com,
       bunk@stusta.de, diegocg@teleline.es, willy@w.ods.org,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050105105731.GA4471@ip68-4-98-123.oc.oc.cox.net>
References: <20050103183621.GA2885@thunk.org> <200501032113.j03LDWsa004885@laptop11.inf.utfsm.cl> <20050105012709.5c970983.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105012709.5c970983.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 01:27:09AM -0800, Andrew Morton wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> >
> > Is there any estimate of the number of daily-straight-from-BK users?
> 
> fwiw, it seems that there were ~1200 downloads of 2.6.10-rc2-mm4 from
> kernel.org.  Almost all via http - only 20 downloads appear in vsftpd.log,
> which seems fishy.  The number of downloads via mirrors is unknown.

The front-page link to the "latest -mm patch" is http. Also, people like
me who use wget and lftp probably prefer to download using http, since
with those clients it ends up working like FTP but without wasting time on
anonymous login (i.e. it happens to be faster).

-Barry K. Nathan <barryn@pobox.com>

