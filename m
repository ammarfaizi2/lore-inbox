Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbULNCgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbULNCgU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbULNCgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:36:19 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:29575 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261376AbULNCgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:36:18 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?b?GyRCNUhGIzFRGyhC?=
	 =?iso-2022-jp?b?GyRCTEAbKEI=?= <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
X-Message-Flag: Warning: May contain useful information
References: <20041213109.5NKezuGE9PMejMSM@topspin.com>
	<20041213109.iziHvQZqtmP83gmx@topspin.com>
	<20041214.113023.65866789.yoshfuji@linux-ipv6.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 13 Dec 2004 18:36:16 -0800
In-Reply-To: <20041214.113023.65866789.yoshfuji@linux-ipv6.org> (YOSHIFUJI
 Hideaki's message of "Tue, 14 Dec 2004 11:30:23 +0900 (JST)")
Message-ID: <52y8g138tb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][v3][16/21] IPoIB IPv6 support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 14 Dec 2004 02:36:17.0483 (UTC) FILETIME=[B01D59B0:01C4E185]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    YOSHIFUJI> Please put ARPHRD_INFINIBAND after ARPHRD_ARCNET like
    YOSHIFUJI> other places.

Thanks, I've made this update.

Thanks,
  Roland

