Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWHAGYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWHAGYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWHAGYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:24:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161153AbWHAGYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:24:17 -0400
Date: Mon, 31 Jul 2006 23:22:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, jamagallon@ono.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Message-Id: <20060731232243.65468eec.akpm@osdl.org>
In-Reply-To: <20060731165011.GA6659@htj.dyndns.org>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	<44CD0E55.4020206@gmail.com>
	<20060731172452.76a1b6bd@werewolf.auna.net>
	<44CE2908.8080502@gmail.com>
	<1154363489.7230.61.camel@localhost.localdomain>
	<20060731165011.GA6659@htj.dyndns.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 01:50:11 +0900
Tejun Heo <htejun@gmail.com> wrote:

> > It'll be easier just to work outside the -mm tree with all this
> > continued in/out random breakage if people are just going to say "drop
> > xyz patch" rather than actually specifying *what is actually wrong* and
> > getting me to fix the merge (Tejun that last one sentence is a hint ;))
> 
> Okay, took the hint.  Magallon, can you please try the following
> patch?

Gee that's a big scary patch.  Is it considered ready for -mm?  (bearing in
mind -mm's exacting quality standards (heh, I kill me)).

