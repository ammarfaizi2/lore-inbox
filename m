Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHWPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHWPvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUHWPui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:50:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:63908 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265808AbUHWPtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:49:03 -0400
To: root@chaos.analogic.com
Cc: Lei Yang <leiyang@nec-labs.com>, Lee Revell <rlrevell@joe-job.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <4127A15C.1010905@nec-labs.com>
	<20040821214402.GA7266@mars.ravnborg.org>
	<4127A662.2090708@nec-labs.com>
	<20040821215055.GB7266@mars.ravnborg.org>
	<4127B49A.6080305@nec-labs.com>
	<1093121824.854.167.camel@krustophenia.net>
	<4129FAC8.3040502@nec-labs.com>
	<Pine.LNX.4.53.0408231018001.7732@chaos>
From: Andreas Schwab <schwab@suse.de>
X-Yow: You must be a CUB SCOUT!!  Have you made your MONEY-DROP today??
Date: Mon, 23 Aug 2004 17:48:06 +0200
In-Reply-To: <Pine.LNX.4.53.0408231018001.7732@chaos> (Richard B. Johnson's
 message of "Mon, 23 Aug 2004 10:29:20 -0400 (EDT)")
Message-ID: <jevff9svnt.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> A function looks like this:
>
> int present()
> {
>
> }
>
> A prototype for the same function looks like this:
>
> int present(void);
>
> Functions always have "{}". Prototypes never do.

A function definition is also a prototype unless you use oldstyle
definitions.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
