Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTGOTvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTGOTvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:51:50 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:1664 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S269559AbTGOTvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:51:49 -0400
Date: Tue, 15 Jul 2003 22:07:07 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715200707.GA581@sokrates>
References: <20030715180346.GB3843@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030715180346.GB3843@sokrates>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, now, when I can boot the kernel (read some of the other posts in
this thread: I have got the booting working), I have found out that the
modules, which have unresolved symbols, can't be loaded within the
kernel. So far, so good. These unresolved symbols. Are they kernel
errors or are the errors on my side? What can *I* do to fix it, besides
messing with the kernel code? Thanks.

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>
