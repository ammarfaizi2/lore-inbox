Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTIAN6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTIAN6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:58:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61970 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262892AbTIAN6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:58:41 -0400
Date: Mon, 1 Sep 2003 09:48:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: Nick Piggin <piggin@cyberone.com.au>, Ross Clarke <encrypted@geekz.za.net>,
       Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
In-Reply-To: <20030829090129.GE690@schottelius.org>
Message-ID: <Pine.LNX.3.96.1030901094452.21567I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=WkfBGePaEyrk4zXB
Content-ID: <Pine.LNX.3.96.1030901094452.21567J@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--WkfBGePaEyrk4zXB
Content-Type: TEXT/PLAIN; charset=US-ASCII

I have never tried running 2.6 without swap, are there tuning values you
need to avoid performance issues. You have adequate memory, have you
played with swappiness?

I'll try no swap on a machine when I get back from the weekend.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--WkfBGePaEyrk4zXB--
