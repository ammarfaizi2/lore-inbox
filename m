Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVRTl>; Wed, 22 Nov 2000 12:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129521AbQKVRTb>; Wed, 22 Nov 2000 12:19:31 -0500
Received: from Cantor.suse.de ([194.112.123.193]:4360 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129150AbQKVRTQ>;
        Wed, 22 Nov 2000 12:19:16 -0500
Date: Wed, 22 Nov 2000 17:49:13 +0100
Message-Id: <200011221649.eAMGnDr23208@hawking.suse.de>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: Pauline Middelink <middelink@polyware.nl>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
In-Reply-To: <Pine.LNX.4.21.0011221803520.27178-100000@server.serve.me.nl>
X-Yow: Hello.  I know the divorce rate among unmarried Catholic
 Alaskan females!!
From: Andreas Schwab <schwab@suse.de>
In-Reply-To: <Pine.LNX.4.21.0011221803520.27178-100000@server.serve.me.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igmar Palsenberg <maillist@chello.nl> writes:

|> > > #define __bad_udelay() panic("Udelay called with too large a constant")
|> 
|> Can't we change that to :
|> #error "Udelay..."

No.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
