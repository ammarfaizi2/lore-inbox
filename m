Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTIYTiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTIYTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:38:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:65434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbTIYTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:38:45 -0400
Date: Thu, 25 Sep 2003 12:38:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, miltonm@realtime.net,
       rusty@rustcorp.com.au, Omen.Wild@Dartmouth.EDU,
       linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper does not report exit status?
Message-ID: <20030925123837.E18118@osdlab.pdx.osdl.net>
References: <20030919124213.7fc93067.akpm@osdl.org> <200309201855.h8KItHuf000466@sullivan.realtime.net> <20030925114150.A18074@osdlab.pdx.osdl.net> <20030925120536.1252e756.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030925120536.1252e756.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 25, 2003 at 12:05:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > Anything wrong with just setting a SIG_DFL handler?
> 
> Seems that any time we make a change here it looks fine, tests out fine,
> and explodes messily three weeks later.

Heh.  Care to try it? ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
