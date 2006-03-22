Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWCVPgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWCVPgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCVPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:36:23 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:16362 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751332AbWCVPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:36:22 -0500
Date: Wed, 22 Mar 2006 10:37:14 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Mikado <mikado4vn@gmail.com>
Cc: stefano.melchior@openlabs.it, user-mode-linux-user@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Cannot debug UML
Message-ID: <20060322153714.GA3975@ccure.user-mode-linux.org>
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX> <44215B8F.6060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44215B8F.6060400@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 09:13:35PM +0700, Mikado wrote:
> Debugging UML requires running it under TT mode. 

No, it doesn't.  Never has.

> Normally I run UML
> under SKAS mode, everything is OK. I cannot get into GDB under SKAS mode
> whenever I use 'debug' option.

Because it's not needed.  In skas mode, you just gdb the thing, just like
anything else.

				Jeff
