Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270699AbTGUTrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGUTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:47:35 -0400
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:38407
	"EHLO hoist") by vger.kernel.org with ESMTP id S270699AbTGUTrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:47:31 -0400
Date: Mon, 21 Jul 2003 16:02:27 -0400
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Message-ID: <20030721200227.GA789@suburbanjihad.net>
References: <7E1E5890331@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E1E5890331@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
From: nick black <dank@suburbanjihad.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec assumed the extended riemann hypothesis and showed:
> In this case, does it happen if you exit X, or only if you are switching
> to the console while X are active? If it happens only in second case, then
> it is bug (I believe fixed long ago) in XFree mga driver: it was sometime

it is the latter case, thanks for the info!  regardless, the 2.6.0-test1
problems continue; i'll update my x this evening if my version doesn't
contain the fix.

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo
