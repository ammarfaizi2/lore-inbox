Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWJEXij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWJEXij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWJEXij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:38:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:28578 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751468AbWJEXii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:38:38 -0400
From: Andi Kleen <ak@suse.de>
To: kmannth@us.ibm.com
Subject: Re: 2.6.18-mm2 boot failure on x86-64 II
Date: Fri, 6 Oct 2006 01:35:56 +0200
User-Agent: KMail/1.9.3
Cc: mel gorman <mel@csn.ul.ie>, Vivek goyal <vgoyal@in.ibm.com>,
       Steve Fox <drfickle@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610060114.03466.ak@suse.de> <1160091179.5664.17.camel@keithlap>
In-Reply-To: <1160091179.5664.17.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060135.56134.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As of yet I haven't been able to recreate the hang.  I am running
> similar HW to Steve. 

That was on a 4 core Opteron with Tyan board  (S2881) and AMD-8111 
chipset.

-Andi
