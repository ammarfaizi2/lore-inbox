Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVAFCPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVAFCPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 21:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVAFCPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 21:15:01 -0500
Received: from mail.aei.ca ([206.123.6.14]:15075 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262683AbVAFCO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 21:14:58 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: starting with 2.7
Date: Wed, 5 Jan 2005 22:15:52 -0500
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       tytso@mit.edu, davidsen@tmr.com, bunk@stusta.de, diegocg@teleline.es,
       willy@w.ods.org, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
References: <20050103183621.GA2885@thunk.org> <20050105012709.5c970983.akpm@osdl.org> <20050105105731.GA4471@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20050105105731.GA4471@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501052215.54214.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 January 2005 05:57, Barry K. Nathan wrote:
> On Wed, Jan 05, 2005 at 01:27:09AM -0800, Andrew Morton wrote:
> > Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > >
> > > Is there any estimate of the number of daily-straight-from-BK users?
> > 
> > fwiw, it seems that there were ~1200 downloads of 2.6.10-rc2-mm4 from
> > kernel.org.  Almost all via http - only 20 downloads appear in vsftpd.log,
> > which seems fishy.  The number of downloads via mirrors is unknown.
> 
> The front-page link to the "latest -mm patch" is http. Also, people like
> me who use wget and lftp probably prefer to download using http, since
> with those clients it ends up working like FTP but without wasting time on
> anonymous login (i.e. it happens to be faster).

Or those like me who use bk pull...

Maybe we should setup an 'opt in / open logging' type concept so we can know
how many people test a release.  It would be very interesting to see if the number
of more testers (or tester days) does lead to a more stable release.

Ed Tomlinson
