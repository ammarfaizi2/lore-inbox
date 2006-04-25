Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDYCud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDYCud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDYCud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:50:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751350AbWDYCud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:50:33 -0400
Date: Mon, 24 Apr 2006 19:50:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: sekharan@us.ibm.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
In-Reply-To: <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604241948560.3701@g5.osdl.org>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
 <20060425023527.7529.9096.sendpatchset@localhost.localdomain>
 <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Linus Torvalds wrote:
> 
> Patches 1-2 applied.

Actually, I take that back. The second one doesn't apply to my tree, so I 
assume it's against the -mm tree, and that I'll get this series through 
Andrew.

Btw, can you fix your mailer to put your real name in your email address, 
please?

		Linus
