Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUIURIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUIURIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUIURIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:08:55 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:24279 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S267866AbUIURIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:08:54 -0400
Message-ID: <41506005.1040300@pantasys.com>
Date: Tue, 21 Sep 2004 10:08:21 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
References: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain> <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Sep 2004 17:01:32.0109 (UTC) FILETIME=[A4F19FD0:01C49FFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:
> # rarp -a
> This kernel does not support RARP.

from man rarp:

NOTE
         This program is obsolete.  From version 2.3, the Linux kernel no
	longer contains  RARP  support.   For   a   replacement   RARP
	daemon, see ftp://ftp.dementia.org/pub/net-tools

peter
