Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVCXBBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVCXBBC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCXBBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:01:02 -0500
Received: from fmr16.intel.com ([192.55.52.70]:13209 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261606AbVCXBA5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:00:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 0/6] freepgt: free_pgtables shakeup
Date: Wed, 23 Mar 2005 17:00:06 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F032455F2@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] freepgt: free_pgtables shakeup
Thread-Index: AcUwCB0OB/daBqbcQ6i7Cb1gPBqn7QAAtFZw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>
Cc: "Hugh Dickins" <hugh@veritas.com>, <akpm@osdl.org>,
       <benh@kernel.crashing.org>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Mar 2005 01:00:07.0755 (UTC) FILETIME=[D265B9B0:01C5300C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>OK, attached is my first cut at slimming down the boundary tests.
>I have only had a chance to try it on i386, so I hate to drop it
>on you like this - but I *have* put a bit of thought into it....
>Treat it as an RFC, and I'll try to test it on a wider range of
>things in the next couple of days.
>
>Not that there is anything really nasty with your system David,
>so I don't think it will be a big disaster if I can't get this to
>work.
>
>Goes on top of Hugh's 6 patches.

Runs on ia64.  Looks much cleaner too.

-Tony
