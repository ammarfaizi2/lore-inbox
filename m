Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUECXkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUECXkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUECXkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:40:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:63450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264168AbUECXjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:39:53 -0400
Date: Mon, 3 May 2004 16:32:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead PC9800 IDE support
Message-Id: <20040503163220.437c2921.rddunlap@osdl.org>
In-Reply-To: <200405040135.14688.bzolnier@elka.pw.edu.pl>
References: <200405040135.14688.bzolnier@elka.pw.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004 01:35:14 +0200 Bartlomiej Zolnierkiewicz wrote:

| 
| It was added in 2.5.66 but PC9800 subarch is still non-buildable.
| Also this is one big hack and only half-merged.
| 

It's fairly simple to make it buildable, but it's still a hack
that no one seems to want to support, so I agree, kill it.

Can we kill the rest of it too?

--
~Randy
