Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWC1Ohn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWC1Ohn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWC1Ohn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:37:43 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:20638 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932255AbWC1Ohm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:37:42 -0500
Date: Tue, 28 Mar 2006 16:38:46 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Random GCC segfaults -- Was: [2.6.16] slab error in
 slab_destroy_objs(): cache `radix_tree_node'...
Message-ID: <20060328163846.272af289@localhost>
In-Reply-To: <20060328163027.1e755745@localhost>
References: <20060326215346.1b303010@localhost>
	<20060328095521.52ea3424@localhost>
	<20060328004137.607e51db.akpm@osdl.org>
	<20060328112241.40b9c975@localhost>
	<20060328132346.GB3300@elf.ucw.cz>
	<20060328163027.1e755745@localhost>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 16:30:27 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> I'm re-testing with 2.6.15.6 --> it is compiling by some hours without
> a single segfault.

Maybe I've exagerated here, it is finished now:

real    106m35.548s
user    56m11.111s
sys     33m48.371s

No problems as expected.

-- 
	Paolo Ornati
	Linux 2.6.15.6 on x86_64
