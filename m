Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJHSco>; Tue, 8 Oct 2002 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSJHSco>; Tue, 8 Oct 2002 14:32:44 -0400
Received: from tapu.f00f.org ([66.60.186.129]:13288 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261424AbSJHScn>;
	Tue, 8 Oct 2002 14:32:43 -0400
Date: Tue, 8 Oct 2002 11:38:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008183824.GA4494@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034044736.29463.318.camel@phantasy>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 10:38:55PM -0400, Robert Love wrote:

> Attached patch implements an O_STREAMING file I/O flag which enables
> manual drop-behind of pages.

When/why would you use this instead of O_DIRECT?


  --cw
