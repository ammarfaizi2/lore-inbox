Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUJCURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUJCURI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUJCURI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:17:08 -0400
Received: from charm.il.fontys.nl ([145.85.127.2]:5008 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S268122AbUJCURD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:17:03 -0400
Message-ID: <55879.217.121.83.210.1096834543.squirrel@217.121.83.210>
In-Reply-To: <20041003123254.4de22bfa.akpm@osdl.org>
References: <56986.217.121.83.210.1096826639.squirrel@217.121.83.210>
    <20041003123254.4de22bfa.akpm@osdl.org>
Date: Sun, 3 Oct 2004 22:15:43 +0200 (CEST)
Subject: Re: [Patch] nfsd: Insecure port warning shows decimal IPv4 address
From: "Ed Schouten" <ed@il.fontys.nl>
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, October 3, 2004 9:32 pm, Andrew Morton said:
> There's a NIPQUAD macro to make this a bit tidier.

Yes, I heard that 3 minutes after I mailed this patch to you guys ;-) I'll
take a look at it tomorrow.

Yours,
-- 
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
 GnuPG key: 0xD6A1AF3E
