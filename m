Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbUDFQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbUDFQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:58:39 -0400
Received: from adsl-207-245-72-121.cust.oldcity.dca.net ([207.245.72.121]:39950
	"EHLO cattlegrid.net") by vger.kernel.org with ESMTP
	id S263901AbUDFQ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:58:38 -0400
Date: Tue, 6 Apr 2004 12:58:36 -0400
From: christophe barbe <christophe@cattlegrid.net>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: christophe barbe <christophe@cattlegrid.net>
Subject: 2.6.5-mc1 and laptop_mode
Message-ID: <20040406165836.GA31096@cattlegrid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.23 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.6.5-mc1 (on powerpc) and everything seems fine. I was very
happy to see that the laptop mode patch was on its way to being merge.
The only issue I have is that the proc entry for the laptop mode seems
to have changed from /proc/sys/vm/laptop_mode to
/proc/sys/fs/laptop_mode and the script included in the doc is not aware
of this change.

Thanks,
Christophe

PS: I am not subscribed to lkml so please CC me if necessary.

-- 
Christophe Barbé <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats are absolute individuals, with their own ideas about everything,
including the people they own. --John Dingman
