Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWFNTWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWFNTWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWFNTWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:22:42 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:44434 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750816AbWFNTWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:22:42 -0400
Date: Wed, 14 Jun 2006 15:22:31 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060614192231.GA5325@ccure.user-mode-linux.org>
References: <20060613182129.GA4619@ccure.user-mode-linux.org> <20060613234551.69651.qmail@web25218.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613234551.69651.qmail@web25218.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 01:45:51AM +0200, Paolo Giarrusso wrote:
> If that problem has been fixed, this would imply that SKAS should
> work on x86-64... or not? 

No, this has nothing to do with skas or ia32 emulation.  It was a
straightforward register corruption bug.

				Jeff
