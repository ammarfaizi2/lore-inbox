Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267031AbUBEXTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbUBEXSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:18:37 -0500
Received: from galileo.bork.org ([66.11.174.156]:12996 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S267031AbUBEXRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:17:20 -0500
Date: Thu, 5 Feb 2004 18:17:19 -0500
From: Martin Hicks <mort@wildopensource.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove __exit from mptscsih_exit()
Message-ID: <20040205231719.GC28976@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James and Andrew

I needed to apply this patch to get my kernel to link on ia64.  The
patch is against 2.6.2-mm1

thanks
mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
