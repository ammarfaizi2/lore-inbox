Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVIQEWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVIQEWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVIQEWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:22:25 -0400
Received: from dvhart.com ([64.146.134.43]:27525 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750874AbVIQEWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:22:25 -0400
Date: Fri, 16 Sep 2005 21:22:30 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <496480000.1126930950@[10.10.2.4]>
In-Reply-To: <488840000.1126921898@[10.10.2.4]>
References: <20050916022319.12bf53f3.akpm@osdl.org> <488840000.1126921898@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Friday, September 16, 2005 18:51:38 -0700):

> 
> Seems to have broken networking on my x86_64 box. (previous releases were
> fine). appears to boot all the way up, then sulk without talking to the
> test server any more.
> 
> Boot log is here, but not sure there's anything interesting in it:
> 
> http://test.kernel.org/12937/debug/console.log
> 
> Um. buggered if I know what to do with that, save playing chop-search, which
> is rather boring. I guess I'll retest to check if it's transient, but I
> doubt it.

Humpf. reran it, and it went away. So either an intermittent failure,
or sunspots.

M.

