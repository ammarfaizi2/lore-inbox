Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTKKPBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTKKPBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:01:18 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:43136
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263527AbTKKPBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:01:18 -0500
Date: Tue, 11 Nov 2003 10:00:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
cc: Dong V Nguyen <dvnguyen@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel: Bind interrupt question.
In-Reply-To: <Pine.LNX.4.53.0311110939050.8688@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311110956460.8688@montezuma.fsmlabs.com>
References: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
 <20031110224822.GE930@krispykreme> <Pine.LNX.4.53.0311110939050.8688@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Zwane Mwaikambo wrote:

> > Its part of the support for > 32way machines, but it looks like its
> > broken for some configurations (Im guessing you have CONFIG_NR_CPUS set
> > to 32).
> 
> There was a fix which went in for something similar on i386 a while back.

And here is a link; PPC64 appears to have the older version

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=uoUN.V9.15%40gated-at.bofh.it&rnum=1&prev=/groups%3Fq%3Dsmp_affinity%2Bi386%2BZwane%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3DuoUN.V9.15%2540gated-at.bofh.it%26rnum%3D1
