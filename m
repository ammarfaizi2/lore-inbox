Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWBHQmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWBHQmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWBHQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:42:12 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:19857 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030361AbWBHQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:42:12 -0500
Date: Wed, 8 Feb 2006 11:43:01 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Ulrich Drepper <drepper@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/8] UML - Define jmpbuf access constants
Message-ID: <20060208164301.GC5240@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org> <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com> <20060207185707.GB6841@ccure.user-mode-linux.org> <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 11:23:42AM -0800, Ulrich Drepper wrote:
> If you need this
> functionality, implement it yourself.  setjmp is most likely overkill
> anyway.

OK, I'll roll my own version.

				Jeff
