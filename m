Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTLRDfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 22:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTLRDfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 22:35:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:7583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264923AbTLRDff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 22:35:35 -0500
Date: Wed, 17 Dec 2003 19:36:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: smiler@lanil.mine.nu, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
Message-Id: <20031217193600.1139f7c0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312172220060.2348@localhost.localdomain>
References: <20031217014350.028460b2.akpm@osdl.org>
	<200312171037.16969.andrew@walrond.org>
	<3FE039F5.5030703@lanil.mine.nu>
	<20031217035105.3c0bd533.akpm@osdl.org>
	<Pine.LNX.4.58.0312172220060.2348@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
> Quite frankly I am becoming concerned about the number of patches that are 
>  queued for post 2.6.0.  It is beginning to look like 2.6.0 might be nice 
>  and quiet while 2.6.1+ are going to be quite messy as all the things "on 
>  hold" get put in.

Well, most of these things do address real problems.  It's a matter of
feeding them in at an appropriate rate and with a higher level of testing.

>  I'm going to do my part by pounding heavily on -mm kernels since that 
>  appears where all this is ending up.

That would be useful.  Testing on non-ia32 platforms remains a concern.  I
test on ia64 and ppc64, but I'm not aware of anyone regularly testing -mm
things on other architectures.
