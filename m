Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUBNGy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 01:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUBNGy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 01:54:59 -0500
Received: from h0060089601a0.ne.client2.attbi.com ([24.34.92.88]:56290 "EHLO
	sevoog.kriation.com") by vger.kernel.org with ESMTP id S264855AbUBNGy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 01:54:58 -0500
Date: Sat, 14 Feb 2004 01:54:59 -0500
From: Armen Kaleshian <akaleshian@kriation.com>
To: ameer armaly <ameer@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel boot order
Message-ID: <20040214065459.GA18235@sevoog.kriation.com>
References: <Pine.LNX.4.58.0402132237320.14412@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402132237320.14412@debian>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do you mean by what parts? The kernel enables your system devices, and then
other services are started based on what you have specified to start at the run
level you've set the machine to boot to.

Please clarify your question so that I may better answer it.

--Armen

On Fri, Feb 13, 2004 at 10:39:11PM -0500, ameer armaly wrote:
: Hi all.
: What determines the order in which parts of the kernel are loaded?  Is it
: in main.c or omsething like that or is it in the link order, or something
: totally different.
: Please reply privately to me at ameer@charter.net since I can't handle 300
: msgs a day.
: Thanks,
: 
: 
: 
: Ameer
: 
: -
: To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
: the body of a message to majordomo@vger.kernel.org
: More majordomo info at  http://vger.kernel.org/majordomo-info.html
: Please read the FAQ at  http://www.tux.org/lkml/
