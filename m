Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTDRTUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTDRTUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:20:49 -0400
Received: from [12.47.58.203] ([12.47.58.203]:9063 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263220AbTDRTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:20:48 -0400
Date: Fri, 18 Apr 2003 12:33:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4: select-speedup.patch breaks Evolution
Message-Id: <20030418123327.0d048282.akpm@digeo.com>
In-Reply-To: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
References: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 19:32:38.0912 (UTC) FILETIME=[458C7800:01C305E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> 2.5.67-mm4 breaks Evolution 1.2.3: when clicking on "Sending/Receiving"
> toolbar button, Evolution displays the progress dialog box but it hangs
> forever, that is, no mail is sent or received. All my accounts are POP3.
> 
> Reverting "select-speedup.patch" fixes the problem.

Ah.  Thanks for the detective work.  I'll take a closer look.

