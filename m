Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDQPxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTDQPxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:53:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37137
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261323AbTDQPxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:53:17 -0400
Subject: Re: RedHat 9 and 2.5.x support
From: Robert Love <rml@tech9.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030417150321.GC16335@wind.cocodriloo.com>
References: <20030416165408.GD30098@wind.cocodriloo.com>
	 <1050517953.598.16.camel@teapot.felipe-alfaro.com>
	 <20030417150321.GC16335@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050595500.17830.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 17 Apr 2003 12:05:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-17 at 11:03, Antonio Vargas wrote:

> 2. RH9 procutils _seems_ to work fine: I can do "vmstat 1" whereas the older
>    gentoo image from summer I used to test boot 2.5 didn't.

It does work fine.

The Red Hat 9 procps is very recent, even with some nice NPTL
enhancements.  If you want to try a newer release, you can get a CVS
snapshot from http://tech9.net/rml/procps.  But the RH9 version should
be fine in 2.5.

	Robert Love

