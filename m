Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWCPXiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWCPXiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCPXiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:38:03 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:31142 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751296AbWCPXiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:38:01 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="315178020:sNHT17812304"
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "Bryan O'Sullivan" <bos@pathscale.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 15:37:56 -0800
In-Reply-To: <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com> (Hugh Dickins's message of "Thu, 16 Mar 2006 14:24:47 +0000 (GMT)")
Message-ID: <adahd5ynep7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 23:37:57.0515 (UTC) FILETIME=[A7A14DB0:01C64952]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

