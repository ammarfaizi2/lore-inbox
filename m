Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHVGyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHVGyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHVGyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:54:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266281AbUHVGyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:54:50 -0400
Date: Sat, 21 Aug 2004 23:51:57 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Davis <tadavis@lbl.gov>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: 2.6.8.1-mm3
Message-Id: <20040821235157.2b6d2834@lembas.zaitcev.lan>
In-Reply-To: <20040821214824.4bf5e6fd.akpm@osdl.org>
References: <20040820031919.413d0a95.akpm@osdl.org>
	<412821C4.7060402@lbl.gov>
	<20040821214824.4bf5e6fd.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 21:48:24 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > 2) do not try to modprobe -r ub; it will do wonky things to your machine (I tried in a KDE Konsole, and lost the keyboard, and the terminal just scrolled blank lines..)
> 
> Hi, Pete.

Probably ohci and timeouts, if anything.

But actually 2.6.8.1-mm3 locks up on me without ub in the picture, so
paint me suspicious.

-- Pete
