Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbTFSCCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 22:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbTFSCCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 22:02:36 -0400
Received: from mail8.kc.rr.com ([24.94.162.176]:36110 "EHLO mail8.kc.rr.com")
	by vger.kernel.org with ESMTP id S265698AbTFSCCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 22:02:35 -0400
Subject: Re: Coding technique question
From: david nicol <whatever@davidnicol.com>
To: Aschwin Marsman <a.marsman@aYniK.com>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306162202480.1924-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306162202480.1924-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1055988964.1032.25.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Jun 2003 21:16:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i-yi-yi.



/*
 * Clarity concerning the
 *	 do {
 *		...
 *	 } while (0);
 *  construct!
 */
#define MACRO_BLOCK_BEGIN do {
#define MACRO_BLOCK_END } while (0);





> See the Kernel Newbies FAQ at http://kernelnewbies.org/faq/
> Q: "Why do a lot of #defines in the kernel use do { ... } while(0)? "
>  
> Best regards,
>  
> Aschwin Marsman

-- 
David Nicol, independent consultant and contractor
                                        Senator Orrin Hatch rewinds his DVDs

