Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGMNiu>; Sat, 13 Jul 2002 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSGMNit>; Sat, 13 Jul 2002 09:38:49 -0400
Received: from [62.70.58.70] ([62.70.58.70]:14731 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S313305AbSGMNis> convert rfc822-to-8bit;
	Sat, 13 Jul 2002 09:38:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Muli Ben-Yehuda <mulix@actcom.co.il>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: compile the kernel with -Werror
Date: Sat, 13 Jul 2002 15:41:37 +0200
User-Agent: KMail/1.4.1
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20020713102615.H739@alhambra.actcom.co.il>
In-Reply-To: <20020713102615.H739@alhambra.actcom.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207131541.37310.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 July 2002 09:26, Muli Ben-Yehuda wrote:
> A full kernel compilation, especially when using the -j switch to
> make, can cause warnings to "fly off the screen" without the user
> noticing them. For example, wli's patch lazy_buddy.2.5.25-1 of today
> had a missing return statement in a function returning non void, which
> the compiler probably complained about but the warning got lost in the
> noise (a little birdie told me wli used -j64).

Why not add a menu item under kernel hacking?

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

