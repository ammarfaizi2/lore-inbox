Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUCGBPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 20:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUCGBPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 20:15:49 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:30106 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261724AbUCGBPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 20:15:48 -0500
Date: Sat, 6 Mar 2004 17:15:35 -0800
From: Paul Jackson <pj@sgi.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: kangur@polcom.net, mmazur@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Message-Id: <20040306171535.5cbf2494.pj@sgi.com>
In-Reply-To: <m38yidk3rg.fsf@defiant.pm.waw.pl>
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
	<m3brnb8bxa.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
	<m38yidk3rg.fsf@defiant.pm.waw.pl>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Changing kernel config should never change the API.

Linux would be in pretty sad shape if that held.

Incompatible API changes should be rare, but they are an essential part
of our continuing healthy evolution.  In particular, there's a _long_
list of hardware devices that have at some time or other worked on
Linux, but don't anymore - usually because no one is still maintaining
the driver needed.  But sometimes other API's have to change or
disappear as well.

Would you say that a city or county should _never_ raze a building or
remove a road as part of development?

Change happens.  Deal with it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
