Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULBGVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULBGVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbULBGVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:21:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261558AbULBGVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:21:15 -0500
Message-ID: <41AEB44D.2040805@pobox.com>
Date: Thu, 02 Dec 2004 01:21:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Lameter <clameter@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, consider me convinced. I don't want to apply this before I get 2.6.10 
> out the door, but I'm happy with it. I assume Andrew has already picked up 
> the previous version.


Does that mean that 2.6.10 is actually close to the door?

/me runs...

