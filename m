Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUIORXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUIORXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUIORWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:22:25 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:14208 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S266878AbUIORUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:20:05 -0400
Date: Wed, 15 Sep 2004 19:19:52 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915171952.GA15368@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 09:30:42 -0700, Linus Torvalds wrote:
> This is a background mail mainly for driver writers and/or architecture

Thanks, I appreciate the effort (speaking as the maintainer of an
"even more interesting" driver).

Roger
