Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbULMTny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbULMTny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbULMTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:41:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31296 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262283AbULMTAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:00:49 -0500
To: Tom Duffy <tduffy@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041213109.JT1ejUdkRIUXbWOm@topspin.com>
	<1102963464.9258.11.camel@duffman> <52mzwi58zj.fsf@topspin.com>
	<1102964069.9258.20.camel@duffman>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 13 Dec 2004 11:00:48 -0800
In-Reply-To: <1102964069.9258.20.camel@duffman> (Tom Duffy's message of
 "Mon, 13 Dec 2004 10:54:29 -0800")
Message-ID: <52ekhu58gv.fsf@topspin.com>
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
X-OriginalArrivalTime: 13 Dec 2004 19:00:48.0849 (UTC) FILETIME=[0EFABC10:01C4E146]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> Speaking of nits, there are also some formatting issues with
    Tom> the Makefiles that changes in the later patches...

Thanks, I've fixed those intermediate versions as well.

 - R.
