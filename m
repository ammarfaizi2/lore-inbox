Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317757AbSGPFwq>; Tue, 16 Jul 2002 01:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSGPFwp>; Tue, 16 Jul 2002 01:52:45 -0400
Received: from ns.suse.de ([213.95.15.193]:21519 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317757AbSGPFwp>;
	Tue, 16 Jul 2002 01:52:45 -0400
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patchless debugger for U.P x86
References: <20020715183746.72137.qmail@web14205.mail.yahoo.com.suse.lists.linux.kernel> <3D331D01.F756F16B@opersys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Jul 2002 07:55:40 +0200
In-Reply-To: Karim Yaghmour's message of "15 Jul 2002 21:07:12 +0200"
Message-ID: <p73it3gusgz.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour <karim@opersys.com> writes:

> This is just fantastic. I'm glad to see someone ran with the ideas of
> patchless kernel debuggers as described in the Adeos paper and the likes.

There has been another one at http://pice.sourceforge.net for a long time.
Unfortunately it only works for 2.2/i386/UP properly. Fixing it for 2.4 
is not that hard however.

-Andi
