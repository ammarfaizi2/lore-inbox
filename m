Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUJOPlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUJOPlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJOPlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:41:22 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:10228 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S268049AbUJOPlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:41:18 -0400
Date: Fri, 15 Oct 2004 11:37:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Fw: signed kernel modules?
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410151140_MC3-1-8C5D-1649@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2004-10-14 at 23:36 +0200, Roman Zippel wrote:
> > No. I still don't know, why the kernel has to do this? You avoided to 
> > answer this question already before.
>
> Partly to protect against accidentally-corrupted modules causing damage.

  OK, so why no integrity-checking code for the kernel itself?  Surely it too
could be accidentally corrupted...


--Chuck Ebbert  15-Oct-04  11:13:15
