Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTIKPLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbTIKPLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:11:01 -0400
Received: from halon.barra.com ([144.203.11.1]:52703 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S261336AbTIKPKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:10:45 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: Thomas Svedberg <thsv@am.chalmers.se>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hard lock with recent 2.6.0-test kernels
Date: Thu, 11 Sep 2003 07:25:53 -0700
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
References: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
In-Reply-To: <1063272933.26472.16.camel@ampc545.am.chalmers.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309110725.53649.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Svedberg wrote:
> I first experienced total lockup with 2.6.0-test4-mm5 and have now
> tried a few different ones. -test4-mm4 works, test4-bk2 works,
> test4-mm5 locks, test4-bk3 locks, test5-mm1 locks.
> Nothing shows in the logs, and the lock occurs while doing random
> things but only after a few seconds - minutes after i logged in to
> X. sysrq don't work either.
> It is an Compaq Evo 1020v and configs etc. can be found at:
> http://www.am.chalmers.se/~thsv/laptop/

looks to me like my favorite network-related lockup. do you ever get 
it if you disconnect from network?

Fedor.
