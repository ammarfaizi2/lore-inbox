Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSKRV4E>; Mon, 18 Nov 2002 16:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSKRVyZ>; Mon, 18 Nov 2002 16:54:25 -0500
Received: from tapu.f00f.org ([66.60.186.129]:53705 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S264938AbSKRVvf>;
	Mon, 18 Nov 2002 16:51:35 -0500
Date: Mon, 18 Nov 2002 13:58:37 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Larson <plars@linuxtestproject.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: LTP - gettimeofday02 FAIL
Message-ID: <20021118215837.GA9719@tapu.f00f.org>
References: <1037139074.10626.37.camel@plars> <20021114215209.GA25778@tapu.f00f.org> <1037640849.21245.0.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037640849.21245.0.camel@plars>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:34:04AM -0600, Paul Larson wrote:

> So this is a hardware issue? no way around this?

For some people it is a hardware issue.  The way around is not not use
the TSC for certain things.


  --cw
