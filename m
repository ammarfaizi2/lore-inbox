Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315230AbSENGKA>; Tue, 14 May 2002 02:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSENGJ7>; Tue, 14 May 2002 02:09:59 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:26799 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315230AbSENGJ6>; Tue, 14 May 2002 02:09:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Date: Mon, 13 May 2002 18:03:37 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Urban Widmark <urban@teststation.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <02051318033703.00917@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One other thing I forgot to mention....
interrupts logged by your patch:
0008 (abort) (LOTS)
0009 (abort, rxdone)
001a (underrun, abort, txdone)


