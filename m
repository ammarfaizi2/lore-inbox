Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTBFT6Y>; Thu, 6 Feb 2003 14:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTBFT6Y>; Thu, 6 Feb 2003 14:58:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9745 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267573AbTBFT6X>; Thu, 6 Feb 2003 14:58:23 -0500
Date: Thu, 6 Feb 2003 12:04:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-scsi@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
In-Reply-To: <1044559247.4858.49.camel@markh1.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0302061202430.3545-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Feb 2003, Mark Haverkamp wrote:
>
> This moves access of the host element to device since host has been
> removed from struct scsi_cmnd.

This is whitespace-damaged.

Please fix broken mailers. I generally don't bother to fix up whitespace
damage from people who can't bother to have a good mailer. It's just not 
worth it - if I try to fix it up (even if it is often trivial), it just 
means that people will continue to send crap patches to me.

		Linus

