Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUCIAbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCIAbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:31:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:982 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbUCIAbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:31:16 -0500
Date: Mon, 8 Mar 2004 16:33:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-Id: <20040308163316.47b8172b.akpm@osdl.org>
In-Reply-To: <200403090014.03282.thomas.schlichter@web.de>
References: <200403090014.03282.thomas.schlichter@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <thomas.schlichter@web.de> wrote:
>
> P.S.: Wouldn't it be nice if gcc complained about these mistakes?

It does, with -W.  But -W creates vast amounts of less useful warnings.

