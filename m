Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbULMTno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbULMTno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbULMTkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:40:21 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:58686 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262281AbULMSti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:49:38 -0500
To: Tom Duffy <tduffy@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041213109.JT1ejUdkRIUXbWOm@topspin.com>
	<1102963464.9258.11.camel@duffman>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 13 Dec 2004 10:49:36 -0800
In-Reply-To: <1102963464.9258.11.camel@duffman> (Tom Duffy's message of
 "Mon, 13 Dec 2004 10:44:24 -0800")
Message-ID: <52mzwi58zj.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] [PATCH][v3][17/21] Add IPoIB
 (IP-over-InfiniBand) driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 13 Dec 2004 18:49:37.0130 (UTC) FILETIME=[7E9A8CA0:01C4E144]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> Is there a reason why you put this in in an earlier patch and
    Tom> then take it out later?

I guess the reasons are stupidity and bad patch scripts...

Doesn't hurt for now, will be fixed in future versions.

 - R.
