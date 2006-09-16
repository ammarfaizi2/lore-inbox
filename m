Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWIPFt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWIPFt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 01:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWIPFt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 01:49:29 -0400
Received: from 1wt.eu ([62.212.114.60]:44306 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932166AbWIPFt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 01:49:29 -0400
Date: Sat, 16 Sep 2006 07:37:13 +0200
From: Willy Tarreau <w@1wt.eu>
To: Tom Mortensen <tmmlkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: 2.4.x libata resync
Message-ID: <20060916053713.GJ541@1wt.eu>
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:14:07PM -0700, Tom Mortensen wrote:
> To Jeff Garzik & others,
> I was wondering if there are any plans for another resync of the latest
> 2.6.x libata changes back into the 2.4.x kernel?

When Jeff posted his last version (which got merged), he said that it
would be his last work on this backport. I've been regularly checking
what has changed in 2.6, because often some bugs are fixed, but I see
that the code has considerably evolved since the last resync, and I'm
not even sure that those bugfixes are needed for 2.4.

A full resync of latest 2.6 would require a considerable effort it seems.
Do you encounter any problems right now ? I get very few feedback from
SATA users in general.

Regards,
Willy

