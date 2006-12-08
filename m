Return-Path: <linux-kernel-owner+w=401wt.eu-S1425608AbWLHQkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425608AbWLHQkn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425614AbWLHQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:40:43 -0500
Received: from [198.99.130.12] ([198.99.130.12]:39087 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1425613AbWLHQkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:40:42 -0500
Date: Fri, 8 Dec 2006 11:36:21 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: torvalds <torvalds@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] uml:
Message-ID: <20061208163621.GB5944@ccure.user-mode-linux.org>
References: <1165573234.32332.15.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165573234.32332.15.camel@twins>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 11:20:34AM +0100, Peter Zijlstra wrote:
> 
> fixup the work on stack and exit scope trouble by placing the work_struct in
> the uml_net_private data.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Acked-by: Jeff Dike <jdike@addtoit.com>

-- 
Work email - jdike at linux dot intel dot com
