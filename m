Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbTJUA3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJUA3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:29:20 -0400
Received: from [65.172.181.6] ([65.172.181.6]:25830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263404AbTJUA3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:29:19 -0400
Date: Mon, 20 Oct 2003 17:27:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020172732.6b6b3646.akpm@osdl.org>
In-Reply-To: <200310210014.h9L0EZFP003073@turing-police.cc.vt.edu>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<200310201811.18310.schlicht@uni-mannheim.de>
	<20031020144836.331c4062.akpm@osdl.org>
	<200310210001.08761.schlicht@uni-mannheim.de>
	<200310210014.h9L0EZFP003073@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> This ring any bells?  What you want tested? etc etc....

Can you try disabling all fbdev stuff in config?

