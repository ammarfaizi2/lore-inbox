Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTJQSVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTJQSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:21:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:60042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263137AbTJQSVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:21:14 -0400
Date: Fri, 17 Oct 2003 11:19:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mingo@redhat.com, linux-mm@kvack.org
Subject: 2.6.0-test7-mm1 4G/4G hanging at boot
Message-Id: <20031017111955.439d01c8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing this at boot:

Checking if this processor honours the WP bit even in supervisor mode...

then I wait for 1-2 minutes and hit the power button.
This is on an IBM dual-proc P4 (non-HT) with 1 GB of RAM.

Has anyone else seen this?  Suggestions or fixes?

Thanks,
--
~Randy
