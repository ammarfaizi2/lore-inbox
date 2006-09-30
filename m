Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWI3SZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWI3SZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWI3SZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:25:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4309 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751364AbWI3SZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:25:24 -0400
From: Andi Kleen <ak@suse.de>
To: Vincent Legoll <legoll@online.fr>
Subject: Re: [PATCH] off-by-one in kernel command line option parsing
Date: Sat, 30 Sep 2006 20:25:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Vincent Legoll <vincent.legoll@gmail.com>
References: <451EB56C.9020105@online.fr>
In-Reply-To: <451EB56C.9020105@online.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302025.17903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 20:20, Vincent Legoll wrote:
> Here is a patch for what I think is a bug in the kernel,
> please comment / apply as appropriate.


That code is already gone in the latest tree.

-Andi
