Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVFXNIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVFXNIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFXNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:08:47 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63535
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262416AbVFXNGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:06:10 -0400
Date: Fri, 24 Jun 2005 15:06:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Baudis <pasky@ucw.cz>
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050624130604.GK17715@g5.random>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> Cool. Except where the concepts are just different, Cogito mostly
> appears at least equally simple to use as Mercurial. Yes, some features
> are missing yet. I hope to fix that soon. :-)

The user interface and network protocol isn't the big deal, the big deal
is the more efficient on-disk storage format IMHO.
