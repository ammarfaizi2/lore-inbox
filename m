Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCVQAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCVQAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVCVQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:00:15 -0500
Received: from [213.186.44.138] ([213.186.44.138]:46596 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261390AbVCVQAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:00:10 -0500
Date: Tue, 22 Mar 2005 17:00:07 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: Make NFS userspace and server directories cookies independant [patch, fc3, 2.6.10-1.766_FC3]
Message-ID: <20050322160007.GA7631@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	nfs@lists.sourceforge.net
References: <20050321162142.GB46055@dspnet.fr.eu.org> <1111427218.10508.27.camel@lade.trondhjem.org> <20050322000210.GA4681@dspnet.fr.eu.org> <1111450936.10980.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111450936.10980.55.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 07:22:16PM -0500, Trond Myklebust wrote:
> This sort of thing worries me: I think we can do better by hooking
> lseek() on directories. I'll see what I can do.

And the patch is buggy somehow, sometimes loses entries.  Keep it on
hold whie I trace the probm and fix it please.

  OG.

