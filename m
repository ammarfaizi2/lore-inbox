Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVAYDeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVAYDeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAYDeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:34:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:25575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261788AbVAYDd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:33:57 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.48502.243516.563660@samba.org>
Date: Tue, 25 Jan 2005 14:31:02 +1100
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: memory leak in 2.6.11-rc2
In-Reply-To: <41F5BB0D.6090006@osdl.org>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
	<16884.56071.773949.280386@samba.org>
	<16885.47804.68041.144011@samba.org>
	<41F5BB0D.6090006@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

 > I have applied the patch from Linus for the leak in
 > free_pipe_info()
...
 > Do you have today's memleak patch applied?  (cut-n-paste below).

yes :-)

I'm trying the little leak tracking patch from Alexander Nyberg now.

Cheers, Tridge
