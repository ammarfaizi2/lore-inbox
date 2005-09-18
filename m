Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVIRAkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVIRAkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVIRAkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:40:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:10964 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751255AbVIRAkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:40:35 -0400
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: boutcher@cs.umn.edu
Cc: Andrew Morton <akpm@osdl.org>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@muc.de>, James Bottomley <James.Bottomley@steeleye.com>,
       lxie@us.ibm.com, santil@us.ibm.com
In-Reply-To: <20050913051005.GA8771@cs.umn.edu>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <20050912222437.GA13124@sergelap.austin.ibm.com>
	 <20050912161013.76ef833f.akpm@osdl.org>  <20050913051005.GA8771@cs.umn.edu>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 10:38:51 +1000
Message-Id: <1127003932.12994.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm thinking we'll have to add a module paramter to limit
> scatterlist sizes that defaults to the old behaviour.  Let
> me sleep on that and kick it around with Linda tomorrow and
> we'll figure out some kind of solution.

It's not possible to identify the type/version of the target ?

> As Anton already reported, mm3 has an additional set of
> breakages...


