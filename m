Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUBFIiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 03:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbUBFIiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 03:38:17 -0500
Received: from levante.wiggy.net ([195.85.225.139]:38022 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263571AbUBFIiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 03:38:16 -0500
Date: Fri, 6 Feb 2004 09:38:15 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.2 crazy mouse under heavy load
Message-ID: <20040206083815.GS30541@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200402051417.21428.murilo_pontes@yahoo.com.br> <200402051518.42609.nbensa@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402051518.42609.nbensa@gmx.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Norberto Bensa wrote:
> 2.6.2-rc3-mm1. Compiling same packages on Gentoo. When the box starts 
> swapping, it is almost totally unresponsive.

I had the same happen to me with vanilla 2.6.2 yesterday, but I was
messing around with ndiswrappers at the time so it might be unrelated.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

