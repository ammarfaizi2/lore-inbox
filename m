Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTJaIxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 03:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTJaIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 03:53:06 -0500
Received: from platane.lps.ens.fr ([129.199.121.28]:26768 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S263106AbTJaIxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 03:53:04 -0500
Date: Fri, 31 Oct 2003 09:52:49 +0100
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: gandalf@wlug.westbo.se
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: status of ipchains in 2.6?
Message-ID: <20031031085249.GA27594@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1067365417.14002.18.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Please try this patch that just got included in linus tree.
>
>ChangeSet 1.1360, 2003/10/27 00:01:25-08:00, rusty@rustcorp.com.au
>
>       [NETFILTER]: Fix ipchains oops in NAT

This fixes my problem too.

Thanks,

	Éric Brunet
