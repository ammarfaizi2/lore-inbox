Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbTEFSUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264011AbTEFSUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:20:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53515 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264010AbTEFSU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:20:29 -0400
Date: Tue, 6 May 2003 14:27:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: walt <wa1ter@myrealbox.com>
cc: David van Hoose <davidvh@cox.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] Fails on "Uncompressing Kernel" (detailed)
In-Reply-To: <3EB7D399.4090109@myrealbox.com>
Message-ID: <Pine.LNX.3.96.1030506142610.9452C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, walt wrote:

> The configuration menu has changed recently so that support for normal
> console operation is not included by default.  To activate the usual
> console on VT and on VGA requires selecting options that are buried
> in the 'Character device' 'Input device' and 'Graphics support' menu
> sections.  Go all the way to the bottom of each section and you will
> see the obvious items you need to select.  Rather a confusing change.

Was that deliberate? I have to wonder if having a default which doesn't
work for most people is worth the gain (which I don't see, but assume is
there).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

