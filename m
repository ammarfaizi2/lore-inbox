Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263387AbVCJXd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbVCJXd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbVCJXb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:31:28 -0500
Received: from hell.org.pl ([62.233.239.4]:63502 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263411AbVCJX2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:28:40 -0500
Date: Fri, 11 Mar 2005 00:28:41 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: kernel BUG at drivers/serial/8250.c:1256!
Message-ID: <20050310232841.GB30957@hell.org.pl>
References: <20050301230946.GA30841@hell.org.pl> <20050301233720.B17470@flint.arm.linux.org.uk> <20050310224342.D1044@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050310224342.D1044@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Russell King:
> Ok, here's the patch.  Please test and let me know if it resolves your
> problem.  Thanks.

Oh, I thought I did reply to your previous mail. In case you didn't get it,
yes, the patch fixes the problem.
Thanks,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
