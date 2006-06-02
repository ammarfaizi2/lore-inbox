Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWFBIwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWFBIwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWFBIwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:52:08 -0400
Received: from mx1.suse.de ([195.135.220.2]:11753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751337AbWFBIwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:52:07 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm1
References: <6iEI8-6Tx-37@gated-at.bofh.it> <6iG79-11u-23@gated-at.bofh.it>
	<6iGqr-1sJ-3@gated-at.bofh.it> <6iGJN-1SM-17@gated-at.bofh.it>
	<6iIsf-4Eq-11@gated-at.bofh.it> <447E3846.1060302@shaw.ca>
	<447E7CF5.8020401@mbligh.org>
From: Andi Kleen <ak@suse.de>
Date: 02 Jun 2006 10:52:05 +0200
In-Reply-To: <447E7CF5.8020401@mbligh.org>
Message-ID: <p73ac8w0wju.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:
> 
> All sounds very sensible ... but not sure why -mm would hit it all the
> time, and never mainline ...

You can use memeat.c to test the machine with other kernels.
It tends to find such problems reliably. Let it run for some time

http://www.firstfloor.org/~andi/memeat.c

-Andi
