Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUCHB3c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 20:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUCHB3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 20:29:32 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:61301 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262368AbUCHB3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 20:29:31 -0500
Date: Sun, 7 Mar 2004 17:28:47 -0800
From: Paul Jackson <pj@sgi.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: kangur@polcom.net, mmazur@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Message-Id: <20040307172847.46708dcc.pj@sgi.com>
In-Reply-To: <m38yiclby8.fsf@defiant.pm.waw.pl>
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
	<m3brnb8bxa.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
	<m38yidk3rg.fsf@defiant.pm.waw.pl>
	<20040306171535.5cbf2494.pj@sgi.com>
	<m38yiclby8.fsf@defiant.pm.waw.pl>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're talking about the kernel development ...

No.  I mean that even the C API that the kernel presents to
user code will sometimes change or have parts disappear.

To be avoided, yes.  Worth going to substantial lengths
to avoid, yes.  But not absolutely prohibited.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
