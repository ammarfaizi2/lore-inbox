Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVE1L36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVE1L36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVE1L36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:29:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262703AbVE1L34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:29:56 -0400
Subject: Re: PATCH: "Ok" -> "OK" in messages
From: David Woodhouse <dwmw2@infradead.org>
To: "Sean M. Burke" <sburke@cpan.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <42985251.6030006@cpan.org>
References: <42985251.6030006@cpan.org>
Content-Type: text/plain
Date: Sat, 28 May 2005 12:29:52 +0100
Message-Id: <1117279792.32118.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 03:13 -0800, Sean M. Burke wrote:
> The English interjection "OK" is misspelled as "Ok" in a dozen
> messages in the Linux kernel.  The following patch corrects
> those typos from "Ok" to "OK".  It affects no comments or
> symbol-names -- and it stops me wanting to gnaw my fingers off every
> time I see "Ok, booting the kernel."!

If you're going to do that, you might as well fix 'Uncompressing Linux'
to 'Decompressing Linux' too, and stop _me_ from being annoyed as well.

There's another error within the context of your patch too.

-- 
dwmw2

