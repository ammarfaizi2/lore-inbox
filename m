Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275957AbSIUWxp>; Sat, 21 Sep 2002 18:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275958AbSIUWxp>; Sat, 21 Sep 2002 18:53:45 -0400
Received: from holomorphy.com ([66.224.33.161]:46990 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S275957AbSIUWxp>;
	Sat, 21 Sep 2002 18:53:45 -0400
Date: Sat, 21 Sep 2002 15:52:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20020921225204.GT3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209211746590.2336-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209211746590.2336-100000@dad.molina>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 05:52:45PM -0500, Thomas Molina wrote:
> I had a system crash, so this may have some holes in it.  My backup was a 
> week old since this is my testing system.
> The most up-to-date version of this report can be found on my web page at:
> http://members.cox.net/tmolina/kernprobs/status.html

Well, you dropped the __write_lock_failed() oops, but that's been fixed.


Cheers,
Bill
