Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTDGBgY (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTDGBgY (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:36:24 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56588
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263182AbTDGBgX 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:36:23 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1049679689.753.170.camel@localhost>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
	 <20030406183234.1e8abd7f.akpm@digeo.com>
	 <1049679689.753.170.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1049680078.753.173.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 21:47:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 21:41, Robert Love wrote:

> I have not yet tracked down what in 2.5 is broken, but Red Hat's kernel
> obviously does not have this flaw.

I should clarify this.

I do not know if the flaw is in 2.5.  It might be a behavior of Red
Hat's kernel which rpm(8) assumes.

	Robert Love

