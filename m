Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272340AbTG3XoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272341AbTG3XoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:44:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44005 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272340AbTG3XoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:44:03 -0400
Date: Wed, 30 Jul 2003 16:47:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [patch] 4G/4G split patch, 2.6.0-test1-G7
Message-ID: <220550000.1059608856@flay>
In-Reply-To: <Pine.LNX.4.44.0307192337050.13990-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307192337050.13990-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the latest 4G/4G split patch can be found at:
> 
>    http://redhat.com/~mingo/4g-patches/4g-2.6.0-test1-mm1-G7
> 
> besides being a merge to 2.6.0-test-mm1, this version also includes many
> cleanups, bugfixes and speedups. All quirks are fixed and sysenter based
> syscalls work now too.

Any chance of getting a version of this against mainline? test1-mm1
crashes all the time for me, so it's impossible to test this ...
(doesn't apply cleanly to test2-mm1 either, I didn't look closely,
but presumably it's highpmd being dropped, etc).

M.
