Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319082AbSIDPkS>; Wed, 4 Sep 2002 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319183AbSIDPkS>; Wed, 4 Sep 2002 11:40:18 -0400
Received: from p50886EA2.dip.t-dialin.net ([80.136.110.162]:46214 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319082AbSIDPkS>; Wed, 4 Sep 2002 11:40:18 -0400
Date: Wed, 4 Sep 2002 09:44:51 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] Important per-cpu fix. 
In-Reply-To: <20020903.220514.21399526.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209040943260.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, David S. Miller wrote:
> Oh, "I'm" willing to upgrade "my" compiler, it's my users that are the
> problem.  If you impose 3.1 or whatever, I get less people testing on
> sparc64 as a result.

Oh, well. I couldn't use gcc 3.* on sparc64 for some weird reason, gcc 
2.95* is unable to handle all that crap, and the egcs hackup can't handle 
the current kernel code. So what?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

