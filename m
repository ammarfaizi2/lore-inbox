Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbTGUQGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTGUQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:03:42 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:31834 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S270470AbTGUQC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:02:56 -0400
To: lucasvr@gobolinux.org (Lucas Correia Villa Real)
Cc: snoopyzwe <snoopyzwe@sina.com>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: how to calculate the system idle time
References: <3F1C570E.8080607@sina.com>
	<Pine.LNX.4.53.0307210935180.17719@chaos> <3F1C613C.6070109@sina.com>
	<200307211245.34244.lucasvr@gobolinux.org>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 21 Jul 2003 12:17:25 -0400
In-Reply-To: <200307211245.34244.lucasvr@gobolinux.org>
Message-ID: <xlt1xwjam7e.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lucasvr@gobolinux.org (Lucas Correia Villa Real) writes:
> "top" is an utility that cames with the Procps package.

But that's probably not what he needs anyway: by idle time he meant "no
keyboard and mouse input". He should take a look at /proc/interrupts IMHO.
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
