Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVBBNNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVBBNNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVBBNNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:13:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:36309 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262397AbVBBNNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:13:31 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: pageexec@freemail.hu
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Wed, 2 Feb 2005 14:13:26 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser <420151B3.27974.D9F79C@localhost>
In-Reply-To: <420151B3.27974.D9F79C@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502021413.26960.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> one thing that paxtest didn't get right in the 'kiddie' mode is that
> it still ran with an executable stack, that was not the intention but
> rather an oversight, it'll be fixed in the next release. still, this
> shouldn't leave you with a warm and fuzzy feeling about the security
> of intrusion prevention systems that 'pass' the 'kiddie' mode but fail
> the 'blackhat' mode, in the real life out there, only the latter matters
> (if for no other reason, then for natural evolution/adaptation of
> exploit writers).

I apologise for this bug. If someone had pointed this out in a clear and 
to-the-point kind of way, then this would have been fixed a long time ago.

Anyways, if anyone else has any suggestions, fixes, or special wishes for 
PaXtest (some exec-shield specific tests perhaps?), then please speak up now. 
I'd rather not bother this list again about PaXtest related issues.

Groetjes,
Peter.
