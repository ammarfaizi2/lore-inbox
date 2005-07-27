Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVG0EUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVG0EUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 00:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVG0EUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 00:20:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45733 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261266AbVG0EUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 00:20:34 -0400
Subject: RE: kernel optimization
From: Lee Revell <rlrevell@joe-job.com>
To: Al Boldi <a1426z@gawab.com>
Cc: "'Adrian Bunk'" <bunk@stusta.de>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "'Horst von Brand'" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200507270354.GAA27975@raad.intranet>
References: <200507270354.GAA27975@raad.intranet>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 00:20:31 -0400
Message-Id: <1122438032.13598.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 06:53 +0300, Al Boldi wrote:
> Gettimeofday loops using gcc-3.2.2 on 2.4.31 and 2.6.12.
> 
> Also, 2.4 is faster than 2.6!

All this proves is that gettimeofday() is faster on 2.4 than 2.6.
Hardly surprising.

Lee

