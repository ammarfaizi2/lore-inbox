Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVGHXGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVGHXGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVGHXEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:04:10 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:1502 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262957AbVGHXDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:03:09 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 8 Jul 2005 16:03:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050708230303.GA19188@taniwha.stupidest.org>
References: <20050708145953.0b2d8030.akpm@osdl.org> <133660000.1120863575@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133660000.1120863575@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 03:59:35PM -0700, Martin J. Bligh wrote:

> I think we're talking between 2.6.12-git5 and 2.6.12-git6 right? I
> can confirm more explicitly if really need be. 48s -> 45.5s elapsed.

That's a huge difference (5%) --- what hardware is that on?
