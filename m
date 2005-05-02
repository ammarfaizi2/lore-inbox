Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVEBQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVEBQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVEBQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:42:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52135 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261461AbVEBQlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:41:15 -0400
Date: Mon, 2 May 2005 18:41:14 +0200
From: Andi Kleen <ak@suse.de>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, ak@suse.de
Subject: Re: [patch 1/1] x86_64: make string func definition work as intended
Message-ID: <20050502164114.GG7342@wotan.suse.de>
References: <20050501190851.5FD5B45EBB@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501190851.5FD5B45EBB@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree this can be a bit kludgy, so if you want add another solution.

Patch is ok for me, but you have a good chance of having broken
other archs too due to the string.c changes. Probably needs some testing.

-Andi
