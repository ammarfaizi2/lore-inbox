Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVCCJX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVCCJX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVCCJWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:22:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:9627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261786AbVCCJVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:21:34 -0500
Date: Thu, 3 Mar 2005 01:17:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303011755.56fddee0.akpm@osdl.org>
In-Reply-To: <4226CA7E.4090905@pobox.com>
References: <42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> We have all these problems precisely because _nobody_ is saying "I'm 
>  only going to accept bug fixes".  We _need_ some amount of release 
>  engineering.  Right now we basically have none.

Sorry Jeff, but that's crap.  Go look at the commits list.  Every single
patch which has gone into the tree for the past two weeks is a bugfix, I
think.

The most recent non-fix I see is

ChangeSet 1.2044, 2005/02/22 20:44:37-05:00, romieu@fr.zoreil.com

 	[PATCH] r8169: removal of unused #define
 	
 	Removal of unused #define
 	
 	Signed-off-by: Jon Mason <jdmason@us.ibm.com>
 	Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

So pphhhfftt ;)


And the most recent non-trivial not-completely-a-bugfix patch I see
is "USB: Add ioctls to ub", from Feb 17.  And even that's an outlier.
