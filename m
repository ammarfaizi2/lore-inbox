Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL3TG5>; Sat, 30 Dec 2000 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQL3TGr>; Sat, 30 Dec 2000 14:06:47 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:3969 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S130753AbQL3TGf>;
	Sat, 30 Dec 2000 14:06:35 -0500
Message-ID: <3A4E2B0E.C3EE4DBE@pobox.com>
Date: Sat, 30 Dec 2000 10:35:58 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-ll i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Jacobberger <f1j@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: test13-pre6 weird with tdfx.o
In-Reply-To: <3A4E261E.1D34D567@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Jacobberger wrote:

> This is a first for tdfx.o not loading with XFree 4.01.
>
> All prior kernel build through test13-pre5 would load just fine...
>
> Strange...

Very strange - others on this list, self included,
have reported something a bit different:

tdfx.o has not loaded in any kernel since -test12.

The makefile changes have broken it.

Are you certain tdfx.o loads for you in prior -test13
versions? If so, that would be a most disturbing
development...

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
