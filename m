Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267257AbUBMWdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUBMWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:33:18 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5248 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S267257AbUBMWdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:33:15 -0500
Date: Fri, 13 Feb 2004 22:43:09 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402132243.i1DMh9LW000210@81-2-122-30.bradfords.org.uk>
To: <yiding_wang@agilent.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
References: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
Subject: Re: what is the best 2.6.2 kernel code?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Building new kernel from the source failed on fs/proc/array.o.
> Patching with patch file will have numerous warning message which says
> "Reversed patch detected! Assume -R [n]".  From messages, it looks
> like the patch file is outdated.  However, without patch, kernel
> failed on building.  Running patch with force option also failed on
> file patching.
> 
> What is the best working 2.6.2 kernel and patch I can get from source tree?

Please fix your mailer not to post long lines.

The patch-2.6.2.bz2 file is intended to be applied to the 2.6.1 tree,
to update it to 2.6.2.  It doesn't contain post 2.6.2 updates, which
is what your mail implied.

John.
