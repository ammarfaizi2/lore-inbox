Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCDEqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUCDEqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:46:30 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:24545 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261457AbUCDEqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:46:07 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040303200704.17d81bda.akpm@osdl.org>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
	 <1078370073.3403.759.camel@abyss.local>
	 <20040303193343.52226603.akpm@osdl.org>
	 <1078371876.3403.810.camel@abyss.local>
	 <20040303200704.17d81bda.akpm@osdl.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078375495.2718.916.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 20:44:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 20:07, Andrew Morton wrote:

> >  Huh. The numbers shall be other way around of course :)   "smp" kernel
> >  had better performance of some 7000TPM, compared to  4500TPM with
> >  HugeMem kernel. 
> 
> That's a larger difference than I expected.  But then, everyone has been
> mysteriously quiet with the 4g/4g benchmarking.

Yes. It is larger than I expected as well but numbers are pretty
reliable. 

> 
> A kernel profile would be interesting.  As would an optimisation effort,
> which, as far as I know, has never been undertaken.

Just let me know which information you would like me to gather and how
and I'll get it for you.



-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

