Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUE0THi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUE0THi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUE0THi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:07:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:39582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265047AbUE0THh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:07:37 -0400
Date: Thu, 27 May 2004 12:05:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: schizo@debian.org, mcgrof@studorgs.rutgers.edu,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org, debian-kernel@lists.debian.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with
 prism54.org cvs rep
Message-Id: <20040527120544.2fbd4b35.akpm@osdl.org>
In-Reply-To: <40B63639.6080705@pobox.com>
References: <20040524083003.GA3330@ruslug.rutgers.edu>
	<40B63132.4050906@pobox.com>
	<20040527182531.GA8942@scowler.net>
	<40B63639.6080705@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  Luis, you, or somebody should create a new patch series with just the 
>  critical fixes, NO WHITESPACE/FORMATTING CHANGES mixed in, and send 
>  those first.

Whitespace changes are often nice, but they should be the very first
patch[es] in the series.  You should be able to verify that the .o file was
unchanged before and after.

That way they become a no-brainer and it becomes easier to review and
understand the substantive changes.
