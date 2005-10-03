Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVJCImc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJCImc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVJCImc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:42:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30859 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932175AbVJCImc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:42:32 -0400
Date: Mon, 3 Oct 2005 01:42:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com, coywolf@gmail.com,
       greg@kroah.com
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003014201.130abcef.pj@sgi.com>
In-Reply-To: <1128327126.14695.40.camel@twins>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<1128327126.14695.40.camel@twins>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter wrote:
> On that last sentence, does quilt support having different subjects for
> different patches?

I'm missing a step in your thinking here - what does quilt
have to do with patch subjects?

I use quilt, but I don't use it to send patches.  To send
patches, I use sendpatchset:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
