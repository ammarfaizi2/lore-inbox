Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSJOA7i>; Mon, 14 Oct 2002 20:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJOA7i>; Mon, 14 Oct 2002 20:59:38 -0400
Received: from tapu.f00f.org ([66.60.186.129]:22435 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262258AbSJOA7h>;
	Mon, 14 Oct 2002 20:59:37 -0400
Date: Mon, 14 Oct 2002 18:05:31 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniele Lugli <genlogic@inrete.it>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-ID: <20021015010531.GA11639@tapu.f00f.org>
References: <20021014202404.GA10777@tapu.f00f.org> <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:00:26PM -0200, Rik van Riel wrote:

> Would it be a good idea to add -Wshadow to the kernel compile
> options by default ?

Yes, I think so.  Last time I tried this it produced quite a bit of
output.


  --cw
