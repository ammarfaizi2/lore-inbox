Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUIINSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUIINSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIINSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:18:30 -0400
Received: from dhcp164.rrze.uni-erlangen.de ([192.44.87.164]:2176 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263448AbUIINS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:18:26 -0400
Date: Thu, 9 Sep 2004 14:27:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steve Underwood <steveu@coppice.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: persistent ptys
Message-ID: <20040909122714.GA1065@elf.ucw.cz>
References: <4139F3FA.1070107@coppice.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139F3FA.1070107@coppice.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems BSD style ptys are on the way out, and most systems will soon 
> have just Unix98 style ptys. This makes me want to move something to 
> Unix98 ptys, but I'm not sure of the appropriate way. The issue is that 
> things like HylaFAX expect to work with well known, persistent, names 
> for modem ports. A 100% soft modem in user space can easily provide that 
> with BSD ptys. With Unix98 ptys it is not so obvious what to
> do. Most 

Do you actually have user-space softmodem implementation? Is it
open-source? I guess it would be very interesting for remaining modem
users :-).
								Pavel
-- 
When do you have heart between your knees?
