Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131178AbQL3TKu>; Sat, 30 Dec 2000 14:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbQL3TKm>; Sat, 30 Dec 2000 14:10:42 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:36135 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S131178AbQL3TK0>; Sat, 30 Dec 2000 14:10:26 -0500
Message-ID: <3A4E2BF1.30054B11@xmission.com>
Date: Sat, 30 Dec 2000 11:39:45 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: test13-pre6 weird with tdfx.o
In-Reply-To: <3A4E261E.1D34D567@xmission.com> <3A4E2B0E.C3EE4DBE@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:

> Frank Jacobberger wrote:
>
> > This is a first for tdfx.o not loading with XFree 4.01.
> >
> > All prior kernel build through test13-pre5 would load just fine...
> >
> > Strange...
>
> Very strange - others on this list, self included,
> have reported something a bit different:
>
> tdfx.o has not loaded in any kernel since -test12.
>
> The makefile changes have broken it.
>
> Are you certain tdfx.o loads for you in prior -test13
> versions? If so, that would be a most disturbing
> development...
>
> jjs

Yes your right... I just haven't noticed... Why doesn't someone fix it?

Frank

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
