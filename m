Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRFFLCW>; Wed, 6 Jun 2001 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbRFFLCC>; Wed, 6 Jun 2001 07:02:02 -0400
Received: from [217.6.75.12] ([217.6.75.12]:31382 "EHLO ftp.prs.de")
	by vger.kernel.org with ESMTP id <S261700AbRFFLBv>;
	Wed, 6 Jun 2001 07:01:51 -0400
Message-ID: <3B1E0ECC.1E489A9@internetwork-ag.de>
Date: Wed, 06 Jun 2001 13:06:52 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rico Tudor <rico-linux-kernel@patrec.com>
CC: tip@prs.de, linux-kernel@vger.kernel.org
Subject: Re: lots of pppd (down) stall SMP linux-2.4.x (no HIGHMEM)
In-Reply-To: <20010605204557.32315.qmail@pc7.prs.nunet.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rico Tudor wrote:

> Try your test with "High Memory Support" disabled.

... tried w/o HIGH_MEM support - same result, machine hang-up...

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



