Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbTI3U7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbTI3U7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:59:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:47016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261726AbTI3U7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:59:40 -0400
Date: Tue, 30 Sep 2003 13:59:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andreas Schwarz <usenet.2117@andreas-s.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call traces due to lost IRQ
Message-ID: <20030930135934.B722@osdlab.pdx.osdl.net>
References: <20030930154032.GA795@donald.balu5> <20030930112429.A722@osdlab.pdx.osdl.net> <slrnbnjksd.3pa.usenet.2117@home.andreas-s.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <slrnbnjksd.3pa.usenet.2117@home.andreas-s.net>; from usenet.2117@andreas-s.net on Tue, Sep 30, 2003 at 07:03:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Schwarz (usenet.2117@andreas-s.net) wrote:
> This solved the issue for me.

Great, although I'm a bit confused.  In your last mail you said you were
using 2.6.0-test6-mm1.  That patch is already in mm1, so were you using
plain 2.6.0-test6 by any chance?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
