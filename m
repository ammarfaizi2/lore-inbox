Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267252AbUHIVpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267252AbUHIVpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHIVoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:44:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27603 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267264AbUHIVmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:42:16 -0400
Date: Mon, 9 Aug 2004 14:42:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org
Subject: Re: warning: comparison is always false due to limited range of
 data type
Message-Id: <20040809144202.5034bf28.pj@sgi.com>
In-Reply-To: <20040808193743.6076bdd3.pj@sgi.com>
References: <411562FD.5040500@blue-labs.org>
	<20040807174133.1e368fbc.pj@sgi.com>
	<20040808142107.GB94449@muc.de>
	<20040808193743.6076bdd3.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I forgot to mark this patch, the high2lowuid fix for __convert_uid,
to which I am replying now:

	Signed-off-by: Paul Jackson <pj@sgi.com>

You're welcome to pick this patch up, so mark it and run with it.

But as you can see, I did little building and no testing.  Nor
do I have any plans to do more.

So if you want more expertise, building, testing or assurances, then
you'll probably have to complain and ask (whom, I don't know) for more.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
