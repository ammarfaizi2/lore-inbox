Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWIFHev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWIFHev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWIFHev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:34:51 -0400
Received: from fep03.xtra.co.nz ([210.54.141.243]:58456 "EHLO fep03.xtra.co.nz")
	by vger.kernel.org with ESMTP id S1751574AbWIFHet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:34:49 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Tejun Heo <htejun@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5 
In-reply-to: Your message of "Sun, 03 Sep 2006 15:10:44 +0900."
             <44FA71E4.70408@gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Sep 2006 18:42:03 +1200
Message-ID: <15740.1157524923@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo (on Sun, 03 Sep 2006 15:10:44 +0900) wrote:
>Hmm... Can you try the attached patch and see what happens?  ATM, I'm on 
>the road and can't test the patch, so it's only compile-tested.  This 
>patch basically reverts some of the effects of the following commit and 
>makes PCS update a little bit more aggressive iff necessary.
>
>ea35d29e2fa8b3d766a2ce8fbcce599dce8d2734
>[libata] ata_piix: Consolidate PCS register writing

I am also on the road, without access to the machines that had the ich5
and ich7 problems.  I will not be able to test the patch until about
September 18.

