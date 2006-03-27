Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWC0R5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWC0R5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWC0R5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:57:08 -0500
Received: from pat.uio.no ([129.240.10.6]:59124 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751111AbWC0R5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:57:07 -0500
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Edward Chernenko <edwardspec@yahoo.com>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
References: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 12:56:56 -0500
Message-Id: <1143482216.28645.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.818, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 08:21 -0800, Edward Chernenko wrote:
> This patch adds ident daemon to net/gnuidentd/
> directory.
> Apply to: 2.6.15.1.
> Patch is here:
> http://unwd.sourceforge.net/gnuidentd-2.6.15.patch
> 
> I used two threads: one for connections handling and
> another for tracking /etc/passwd changes through
> inotify.
> Additionally, root can set users hiding rules using
> file in /proc. 
> 
> I'm awaiting your notes/tips.
> Please CC me to <edwardspec@gmail.com>
> 
> Signed-Off-by: Edward Chernenko <edwardspec@gmail.com>

Justification, please.

You haven't even tried to explain to us what is so broken about the
userland identd that it needs to be replaced with a kernel version.

Cheers,
  Trond

