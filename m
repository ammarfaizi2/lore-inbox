Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUBPNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUBPNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:46:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265532AbUBPNpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:45:47 -0500
Date: Mon, 16 Feb 2004 13:48:26 +0000
From: Joe Thornber <thornber@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christophe Saout <christophe@saout.de>, Joe Thornber <thornber@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kthread vs. dm-daemon (was: Oopsing cryptoapi (or loop device?) on 2.6.*)
Message-ID: <20040216134826.GE28615@reti>
References: <1076876668.21968.22.camel@leto.cs.pocnet.net> <20040216034250.EDCC82C053@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216034250.EDCC82C053@lists.samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 02:02:04PM +1100, Rusty Russell wrote:
> Yes, looks like dm-daemon is a workqueue.

Agreed.  I think (hope) we can get rid of dm-daemon entirely.

- Joe
