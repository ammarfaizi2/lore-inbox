Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTDLCn1 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 22:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTDLCn1 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 22:43:27 -0400
Received: from tapu.f00f.org ([202.49.232.129]:59275 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id S263112AbTDLCn0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 22:43:26 -0400
Date: Fri, 11 Apr 2003 19:55:11 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Riley Williams <Riley@Williams.Name>, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-English user messages
Message-ID: <20030412025511.GA13115@f00f.org>
References: <BKEGKPICNAKILKJKMHCAGEPFCFAA.Riley@Williams.Name> <Pine.LNX.4.44.0304101033030.8329-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304101033030.8329-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 10:35:36AM -0700, Linus Torvalds wrote:

> I've used VMS, and error code number encoding is a total heap of
> crap.

What about prefixing known messages with error-numbers, perhaps even
being able to suppress these for sysctl or similar?  Would that not
work both-ways?

The only thing is that it requires more work in the build process...


  --cw
