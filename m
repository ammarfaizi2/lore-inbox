Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267861AbUHPSkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbUHPSkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUHPSkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:40:16 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:3456 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S267861AbUHPSkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:40:09 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	<873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	<87llgfdqb7.fsf@dedasys.com>
From: davidw@dedasys.com (David N. Welton)
Date: 16 Aug 2004 20:38:16 +0200
In-Reply-To: <87llgfdqb7.fsf@dedasys.com>
Message-ID: <874qn353on.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidw@dedasys.com (David N. Welton) writes:

> If it's useful, I suppose I can try backing of to 2.6.7 to see if it
> suffers from the same problem...

2.6.7 is also broken.  Fresh 2.6.7 compiled, and it doesn't work
either.

Kernel config at dedasys.com/kernelconfig

Thanks,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
