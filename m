Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUFKWc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUFKWc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUFKWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:32:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:37558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264375AbUFKWc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:32:28 -0400
Date: Fri, 11 Jun 2004 15:35:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: mike.miller@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6.7
Message-Id: <20040611153512.4c8e9746.akpm@osdl.org>
In-Reply-To: <20040611222613.GA11102@beardog.cca.cpqcorp.net>
References: <20040611222613.GA11102@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
>
> I sent this in earlier this weel but I didn't see any indication
> it was received.

It was included in 2.6.7-rc3-mm1.  I tend not to ack stuff, sorry.  If you
don't hear, assume it went in.

As we're at -rc3 I'd only be merging up very safe or very critical things,
or patches to unimportant or very experimental code.  I don't think this
patch is any of those, is it?
