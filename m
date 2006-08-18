Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWHRJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWHRJrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHRJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:47:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:42983 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751327AbWHRJrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:47:42 -0400
From: Andi Kleen <ak@suse.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Date: Fri, 18 Aug 2006 12:55:46 +0200
User-Agent: KMail/1.9.1
Cc: john stultz <johnstul@us.ibm.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no>
In-Reply-To: <44E588AB.3050900@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181255.46999.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have narrowed it down.  2.6.18-rc4 does not have the 3x time
> problem,  while mm1 have it.  mm1 without the hotfix jiffies
> patch is just as bad.

Can you narrow it down to a specific patch in -mm? 

-Andi
