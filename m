Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVA1WYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVA1WYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVA1WYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:24:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:39139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262798AbVA1WYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:24:32 -0500
Date: Fri, 28 Jan 2005 14:24:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, ak@muc.de,
       zippel@linux-m68k.org, zanussi@us.ibm.com, bob@watson.ibm.com,
       tim.bird@AM.SONY.COM, karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
Message-Id: <20050128142430.1a066a86.akpm@osdl.org>
In-Reply-To: <16890.38062.477373.644205@tut.ibm.com>
References: <16890.38062.477373.644205@tut.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi <zanussi@us.ibm.com> wrote:
>
> This patch is the result of the latest round of liposuction on relayfs
>  - the patch size is now 44K, down from 110K and the 200K before that.
>  I'm posting it as a patch against 2.6.10 rather than -mm in order to
>  make it easier to review, but will create one for -mm once the changes
>  have settled down.

Actually, I'll drop all the relayfs and ltt patches from -mm.  They seem to
have done their job ;)

When things settle down and the code is ready for a new run, you know where
I sit.
