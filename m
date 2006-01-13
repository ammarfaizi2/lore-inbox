Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161520AbWAMJ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161520AbWAMJ43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161521AbWAMJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:56:28 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:7271 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161520AbWAMJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:56:28 -0500
Date: Fri, 13 Jan 2006 01:56:25 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
Message-ID: <20060113095625.GA3707@taniwha.stupidest.org>
References: <b4863171295fdb6e8206.1136922838@serpentine.internal.keyresearch.com> <200601121038.17764.vda@ilport.com.ua> <1137081882.28011.1.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137081882.28011.1.camel@serpentine.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:04:41AM -0800, Bryan O'Sullivan wrote:

> This is true for 64-bit writes over Hypertransport

is this something that will always be or just something current
hardware does?
