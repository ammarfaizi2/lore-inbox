Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135711AbRA0Xmx>; Sat, 27 Jan 2001 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135736AbRA0Xmn>; Sat, 27 Jan 2001 18:42:43 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:49463 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135711AbRA0XmZ>; Sat, 27 Jan 2001 18:42:25 -0500
Message-ID: <3A735CDA.45CEF791@linux.com>
Date: Sat, 27 Jan 2001 23:42:18 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com> <94useu$etc$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the time I had temporary access to my notebook and had a mismatched System.map
file :S

-d

Linus Torvalds wrote:

> In article <3A7285D4.9409E63A@linux.com>, David Ford  <david@linux.com> wrote:
> >I can quickly and easily duplicate it on my notebook by playing music or
> >mpegs in xmms.  It may take a few minutes but it's guaranteed.
> >
> >xmms stalls flat on it's face and anything accessing /proc stalls.  If I get
> >the time to do it, I'll take a gander at it with kdb.
>
> Please, if you see something like this, just do a simple
> <Alt+ScrollLock> followed by <Ctrl+ScrollLock> while in text-mode. The
> magic keystrokes will give a stack trace of the currently running
> process and all processes respectively.

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
