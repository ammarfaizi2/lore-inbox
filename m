Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUDNUZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDNUXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:23:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:4025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbUDNUUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:20:43 -0400
Date: Wed, 14 Apr 2004 13:20:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.5-mm4] Trivial : emu10k1 definition redundancy
Message-ID: <20040414132041.S22989@build.pdx.osdl.net>
References: <1081973268.5445.35.camel@bluerhyme.real3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1081973268.5445.35.camel@bluerhyme.real3>; from Fabian.Frederick@skynet.be on Wed, Apr 14, 2004 at 10:07:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabian Frederick (Fabian.Frederick@skynet.be) wrote:
> Remove emu10k1_t definition redundancy

This one's probably fine.  It'd be nice if you could inline the patches
in your mail (making sure whitespaces won't get munged and lines won't
get linewrapped by your mailer).  Makes it easier to view the patch and
reply with comments inlined in the patch.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
