Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTAPAV4>; Wed, 15 Jan 2003 19:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTAPAV4>; Wed, 15 Jan 2003 19:21:56 -0500
Received: from bitmover.com ([192.132.92.2]:34735 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262492AbTAPAVz>;
	Wed, 15 Jan 2003 19:21:55 -0500
Date: Wed, 15 Jan 2003 16:30:50 -0800
From: Larry McVoy <lm@bitmover.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: 2.5 BK broken?
Message-ID: <20030116003050.GR13619@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
	lm@bitmover.com
References: <200301152329.h0FNTw025436@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301152329.h0FNTw025436@mail.osdl.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-2.5 0] bk pull
> Pull bk://linux.bkbits.net/linux-2.5 -> file://var/kernel/bk/linux-2.5
> ERROR-Lock fail: possible permission problem.

Sorry, it's fixed, I did a clone -l of Linus' tree and forgot to fix one
of the permissions.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
