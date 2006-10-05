Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWJEUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWJEUvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWJEUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:51:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:52106 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932187AbWJEUvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:51:45 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 22:51:31 +0200
User-Agent: KMail/1.9.3
Cc: vgoyal@in.ibm.com, Steve Fox <drfickle@us.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052108.55208.ak@suse.de> <Pine.LNX.4.64.0610052128570.29014@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0610052128570.29014@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052251.31571.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hmm, rather than bugging you with patches now, I'll see what I can find 
> with the x86_64 machines I have access to and see can I reproduce it.

I started the bisect, should finish soon.

-Andi
