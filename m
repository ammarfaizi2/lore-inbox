Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRKONzJ>; Thu, 15 Nov 2001 08:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRKONy7>; Thu, 15 Nov 2001 08:54:59 -0500
Received: from hermes.toad.net ([162.33.130.251]:15555 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280836AbRKONyr>;
	Thu, 15 Nov 2001 08:54:47 -0500
Subject: Re: CS423x audio driver updates for testing
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 08:55:06 -0500
Message-Id: <1005832507.26175.28.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This gets rid of the nasty clicks on the thinkpad. On the TP600
> this leaves us with fully functional sound including save/restore
> (if your bios is not too ancient at least). The mixer changes
> are from Daniel Cobra, I added the ident changes and made the
> driver pick the right (I hope) feature sets for each board.
>
> Can folks with cs42xx series audio give it a test make sure it
> doesn't break anything

Alan: Should I check to see whether these changes need to be ported
to ALSA?

By the way: In your opinion, is ALSA going to get into Linux 2.5?


