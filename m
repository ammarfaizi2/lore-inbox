Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUKYFMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUKYFMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 00:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUKYFMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 00:12:05 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:32951 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262974AbUKYFMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 00:12:01 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/1] uml: fix some ptrace functions returns values
Date: Thu, 25 Nov 2004 05:14:46 +0100
User-Agent: KMail/1.7.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jdike@addtoit.com
References: <20041124000715.E3A2FAB24@zion.localdomain> <41A3F6F6.1040903@osdl.org>
In-Reply-To: <41A3F6F6.1040903@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411250514.46355.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 November 2004 03:50, Randy.Dunlap wrote:
> blaisorblade_spam@yahoo.it wrote:
> > From: Jeff Dike <jdike@addtoit.com>
> >
> > This patch adds ptrace_setfpregs and makes these functions return -errno
> > on failure.

> Looks OK except that someone's SPACEBAR is broken (missing)
> and there are (unneeded/unwanted) parens on the returns.
Yes, that is Jeff Dike's keyboard - it's cursing all over arch/um with that 
style.

I'm going to resend it more conforming to the kernel style.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
