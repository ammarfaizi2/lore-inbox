Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCIA1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCIA1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:27:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:64722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbUCIA1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:27:48 -0500
Date: Mon, 8 Mar 2004 16:29:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Schwab <schwab@suse.de>
Cc: thomas.schlichter@web.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-Id: <20040308162947.4d0b831a.akpm@osdl.org>
In-Reply-To: <jeptbmlxb2.fsf@sykes.suse.de>
References: <200403090014.03282.thomas.schlichter@web.de>
	<jeptbmlxb2.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> wrote:
>
> Thomas Schlichter <thomas.schlichter@web.de> writes:
> 
> > P.S.: Wouldn't it be nice if gcc complained about these mistakes?
> 
> Among these 18 cases are 13 false positives. :-)

Rename Thomas's script to crappy-code-detector.sh and its hit rate goes to
100% ;)


