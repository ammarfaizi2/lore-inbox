Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUHQJBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUHQJBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 05:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUHQJBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 05:01:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:32161 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268146AbUHQJBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 05:01:14 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87k6vytbjo.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	 <873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	 <87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com>
	 <1092729140.9539.129.camel@gaston>  <87k6vytbjo.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1092732749.10506.151.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 18:52:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.6.6 sleeps/wakes just fine.  I had a halfhearted look through the 7
> 2.6.patch, searching on things like 'ppc' and 'macintosh', but didn't
> 2.6.see much that jumped out at me.

Best would be if you could try the various 2.6.7-rc patches ...

Ben.


