Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbSJFAkw>; Sat, 5 Oct 2002 20:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263102AbSJFAkw>; Sat, 5 Oct 2002 20:40:52 -0400
Received: from holomorphy.com ([66.224.33.161]:5332 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263100AbSJFAkv>;
	Sat, 5 Oct 2002 20:40:51 -0400
Date: Sat, 5 Oct 2002 17:44:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gigi Duru <giduru@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021006004438.GG10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gigi Duru <giduru@yahoo.com>, linux-kernel@vger.kernel.org
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 12:36:50PM -0700, Gigi Duru wrote:
> As an embedded developer, I can't stand bloat. I think
> an OS designer should feel the same, and develop in a
> fully modular and configurable manner, going for both
> speed and size. For a long time I've felt that Linux
> has got it right, but lately I'm not that sure
> anymore. 

Identifying the portions of the kernel with the largest codesize and/or
static data size would help other developers accommodate your needs.
Similarly for dynamic boot-time and runtime allocations.

Even better, if you yourself took action to correct this regression it
would be as welcome as any other Linux development activity.


Bill
