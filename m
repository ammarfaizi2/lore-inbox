Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTIODQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 23:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTIODQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 23:16:51 -0400
Received: from waste.org ([209.173.204.2]:33758 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262427AbTIODQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 23:16:50 -0400
Date: Sun, 14 Sep 2003 22:16:43 -0500
From: Matt Mackall <mpm@selenic.com>
To: kartikey bhatt <kartik_me@hotmail.com>
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Testing Module Cleanup.
Message-ID: <20030915031643.GI4489@waste.org>
References: <Law11-F123RpXbD4dSr0004cdfc@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-F123RpXbD4dSr0004cdfc@hotmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 12:30:10AM +0530, kartikey bhatt wrote:
> Hi James.
> 
> I have cleaned up the testing module.
> A complete rewrite.
> Code is reduced by almost 1900+ lines in tcrypt.c.
> I have compiled and test it on my machine.
> The kernel size is reduced by 5 Kb.
> I am including the patch for testing as an attachment.
> It provides uniform interface for adding new tests.
> Anyway, I think, now you won't call it a dirty module.
> I expect changes in the comments at the beginning of source files.
> Any suggestions are welcome.
> 
>                    -Kartikey Mahendra Bhatt

It's generally preferred to post patches in the body of your messages
rather than as an attachment. The attachment you posted also appears
to be empty.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
