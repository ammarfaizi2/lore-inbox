Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSG3SI5>; Tue, 30 Jul 2002 14:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSG3SI5>; Tue, 30 Jul 2002 14:08:57 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:64209 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317003AbSG3SI4>; Tue, 30 Jul 2002 14:08:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Vincent Hanquez <tab@crans.org>
Subject: Re: 2.5.25: spurious 8259A interrupt: IRQ7
Date: Tue, 30 Jul 2002 10:42:31 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200207300952.28460.EricAltendorf@orst.edu> <20020730175932.GA29379@darwin.crans.org>
In-Reply-To: <20020730175932.GA29379@darwin.crans.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301042.31667.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 July 2002 10:59, Vincent Hanquez wrote:
> There were a discussion about this warning some time ago.
> As far as I remember, it's just a interrupt which is not registered
> by any peripheral.
> this is not a kernel bug, just a buggy hardware.

OK -- I'll take that explanation.  I mentioned it because it happened 
in the first half hour of using this kernel specifically, and I'd 
never seen it before.

Thanks,

Eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
