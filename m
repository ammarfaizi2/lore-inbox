Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268211AbUHQM7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268211AbUHQM7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUHQM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:59:31 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:2176 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S268211AbUHQM7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:59:30 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	<873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	<87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com>
	<1092729140.9539.129.camel@gaston> <87k6vytbjo.fsf@dedasys.com>
	<1092732749.10506.151.camel@gaston>
From: davidw@dedasys.com (David N. Welton)
Date: 17 Aug 2004 14:57:34 +0200
Message-ID: <87isbh6hxd.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> > 2.6.6 sleeps/wakes just fine.  I had a halfhearted look through
> > the 7 2.6.patch, searching on things like 'ppc' and 'macintosh',
> > but didn't 2.6.see much that jumped out at me.

> Best would be if you could try the various 2.6.7-rc patches ...

 .... patching, compiling ....

rc1 sleeps/wakes, rc2 does not.

-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
