Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264022AbTCXAoo>; Sun, 23 Mar 2003 19:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264023AbTCXAoo>; Sun, 23 Mar 2003 19:44:44 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:5848 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264022AbTCXAoo>; Sun, 23 Mar 2003 19:44:44 -0500
To: John M Collins <jmc@xisl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about SIS963 Bridges
From: Andi Kleen <ak@muc.de>
Date: Mon, 24 Mar 2003 01:55:38 +0100
In-Reply-To: <20030323234008$0084@gated-at.bofh.it> (John M Collins's
 message of "Mon, 24 Mar 2003 00:40:08 +0100")
Message-ID: <m3ptoh4m7p.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030323234008$0084@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Collins <jmc@xisl.com> writes:
>
> I've followed a long thread about fixing this on transparent bridges -
> can some kind guru give me some runes to get this machine off the
> ground? A quick and dirty my-machine-only hack would be fine for me if
> not fully aesthetically pleasing to all and sundry.

Try applying the 2.5 ACPI backport patches from sourceforge and enable ACPI
and see if that helps.

-Andi

