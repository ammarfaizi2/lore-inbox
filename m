Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTKRNoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTKRNmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:51 -0500
Received: from ns.suse.de ([195.135.220.2]:3794 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262750AbTKRNmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:21 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, dtor_core@ameritech.net
Subject: Re: [PATCH] PS/2 mouse rate setting
References: <20031027140217.GA1065@averell.suse.lists.linux.kernel>
	<20031028035625.GB20145@rivenstone.net.suse.lists.linux.kernel>
	<20031028094709.GA4325@ucw.cz.suse.lists.linux.kernel>
	<200310290136.06439.dtor_core@ameritech.net.suse.lists.linux.kernel>
	<20031029083040.GA18135@ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Oct 2003 13:47:01 +0100
In-Reply-To: <20031029083040.GA18135@ucw.cz.suse.lists.linux.kernel>
Message-ID: <p73y8v48b3u.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> Thanks!

Actually partly being guilty of it too - but as Andries points out it would
make much more sense to convert this stuff to sysctls. There is no
reason at all why you should need to reboot the box just to change the 
settings of the mouse.

[In fact requiring a reboot is very "Windows"-like]

If there is a possibility for merging this I can do a patch ...

-Andi
