Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263508AbUJ2URw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbUJ2URw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbUJ2UOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:14:04 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:43269 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S263504AbUJ2UJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:09:36 -0400
Date: Fri, 29 Oct 2004 21:09:07 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041029200907.GB18508@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <20041029101758.GA7278@atrey.karlin.mff.cuni.cz> <20041029032420.327d65dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029032420.327d65dd.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:24:20AM -0700, Andrew Morton wrote:
 > OK, fair enough.  I'll merge the patch if you talk suse into enabling
 > sysrq-T and sysrq-P and sysrq-M by default ;)
 
you already have those available if /proc/sys/kernel/sysrq is 0.

alt-scrolllock / ctrl-scrolllock / shift-scrolllock.

		Dave

