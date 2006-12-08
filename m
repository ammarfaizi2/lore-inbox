Return-Path: <linux-kernel-owner+w=401wt.eu-S1760768AbWLHQjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760768AbWLHQjj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760771AbWLHQji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:39:38 -0500
Received: from [198.99.130.12] ([198.99.130.12]:39076 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760768AbWLHQji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:39:38 -0500
Date: Fri, 8 Dec 2006 11:33:04 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: UML and fastcall/FASTCALL
Message-ID: <20061208163304.GA5944@ccure.user-mode-linux.org>
References: <20061208125928.GA25427@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208125928.GA25427@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 01:59:28PM +0100, Adrian Bunk wrote:
> UML on i386 is now the only case where fastcall/FASTCALL is not a noop.

If i386 doesn't use it any more, then UML shouldn't either.  The only reason
there's support for it in UML is that I was copying i386.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
