Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTJUQwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTJUQwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:52:15 -0400
Received: from [65.172.181.6] ([65.172.181.6]:4575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbTJUQwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:52:15 -0400
Date: Tue, 21 Oct 2003 09:52:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cset #'s stable?
Message-ID: <20031021095209.A32703@osdlab.pdx.osdl.net>
References: <20031021091347.A7526@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031021091347.A7526@google.com>; from fcusack@fcusack.com on Tue, Oct 21, 2003 at 09:13:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Cusack (fcusack@fcusack.com) wrote:
> Are changeset #'s stable?
> 
> I'm specifically looking at linux-2.5/net/sunrpc/clnt.c,
> "rev 1.1153.63.[123]" which I recorded earlier as 1.1153.48.[123].

No, they are not.  The key, however, is stable (bk changes -k -r<rev>,
for example).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
