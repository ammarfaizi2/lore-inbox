Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUDXCZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUDXCZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 22:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUDXCZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 22:25:05 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2491 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261851AbUDXCZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 22:25:03 -0400
Date: Fri, 23 Apr 2004 22:24:58 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040424022458.GA16166@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898834.7040803@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40898834.7040803@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 05:18:44PM -0400, Timothy Miller wrote:
> In a drive with multiple platters and therefore multiple heads, you 
> could read/write from all heads simultaneously.  Or is that how they 
> already do it?

fwih, there was once a drive that did this. the problem is track alignment.
these days, you'd need seperate motors for each head.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
