Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933081AbWKSTmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081AbWKSTmA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933082AbWKSTl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:41:59 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:64229 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S933081AbWKSTl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:41:58 -0500
Date: Sun, 19 Nov 2006 14:38:38 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org
Subject: Re: uml fails to compile due to missing offsetof
Message-ID: <20061119193838.GB4559@ccure.user-mode-linux.org>
References: <20061119120000.GA4926@aepfle.de> <aday7q7jrds.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aday7q7jrds.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 09:08:47AM -0800, Roland Dreier wrote:
> looks weird to me.  AFAIK the C standard says that offsetof() comes
> from plain old <stddef.h>.

Yes, sorry.

Fixed in my tree, will be send to mainline shortly.

				Jeff
-- 
Work email - jdike at linux dot intel dot com
