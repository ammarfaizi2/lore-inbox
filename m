Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWATMKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWATMKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWATMKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:10:43 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7838 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750757AbWATMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:10:42 -0500
Date: Fri, 20 Jan 2006 21:08:49 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0601200934300.10920@skynet>
References: <43D03C24.5080409@jp.fujitsu.com> <Pine.LNX.4.58.0601200934300.10920@skynet>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060120210353.1269.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What sort of tests would you suggest? The tests I have been running to
> date are
> 
> "kbuild + aim9" for regression testing
> 
> "updatedb + 7 -j1 kernel compiles + highorder allocation" for seeing how
> easy it was to reclaim contiguous blocks

BTW, is "highorder allocation test" your original test code?
If so, just my curious, I would like to see it too. ;-).

Bye.
-- 
Yasunori Goto 



