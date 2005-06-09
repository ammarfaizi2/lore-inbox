Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVFIPvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVFIPvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFIPvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:51:35 -0400
Received: from smtpout02-04.prod.mesa1.secureserver.net ([64.202.165.194]:53719
	"HELO smtpout02-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S262206AbVFIPve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:51:34 -0400
Message-ID: <42A8654F.1020500@coyotegulch.com>
Date: Thu, 09 Jun 2005 11:50:39 -0400
From: Scott Robert Ladd <lkml@coyotegulch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050512)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Has anyone had problems with GCC 4.0 and the kernel?
References: <42A85065.4000108@coyotegulch.com> <17064.22132.219886.207366@alkaid.it.uu.se>
In-Reply-To: <17064.22132.219886.207366@alkaid.it.uu.se>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> gcc-4.0.0 vanilla is broken and miscompiles some ipv4/sysctl stuff.
> More recent 4.0.1 snapshots are OK.

They're rolling release candidates for GCC 4.0.1 at the moment, so I
expect it to be out early next week. I'll simply recommend people wait
for the 4.0.1 release.

I get 2-3 messages per day, steadily, from people with various kernel
and GCC problems. Since I'm not exactly a kernel developer, I wonder why
they think *I* have answers.

Must be Google's fault... ;)

..Scott
