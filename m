Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264875AbUEVBEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUEVBEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUEVBEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:04:13 -0400
Received: from science.horizon.com ([192.35.100.1]:29766 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S264876AbUEVBCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:02:24 -0400
Date: 20 May 2004 06:08:05 -0000
Message-ID: <20040520060805.1620.qmail@science.horizon.com>
From: linux@horizon.com
To: neilb@cse.unsw.edu.au
Subject: Re: 2.6.6 is crashing repeatedly
Cc: akpm@osdl.org, kerndev@sc-software.com, linux-kernel@vger.kernel.org,
       linux@horizon.com
In-Reply-To: <16556.16982.957729.595623@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes... this patch should fix it.
>
> Thanks for the report.

Thanks even more for the fix!

This is indeed playing NFS server to a herd of Suns.

Compiling now.  I'll report again in a week or two if the crashes
stop.  (Sooner if they don't, of course.)
