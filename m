Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132390AbQKWAtt>; Wed, 22 Nov 2000 19:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132403AbQKWAt3>; Wed, 22 Nov 2000 19:49:29 -0500
Received: from dsl-206.169.4.82.wenet.com ([206.169.4.82]:14341 "EHLO
        phobos.illtel.denver.co.us") by vger.kernel.org with ESMTP
        id <S132390AbQKWAtV>; Wed, 22 Nov 2000 19:49:21 -0500
Date: Wed, 22 Nov 2000 16:21:52 -0800 (PST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: uname
In-Reply-To: <20001123010145.A744@werewolf.able.es>
Message-ID: <Pine.LNX.4.20.0011221620440.22722-100000@phobos.illtel.denver.co.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, J . A . Magallon wrote:

> Little question about 'uname'. Does it read data from kernel, /proc or
> get its data from other source ?

uname(1) utility calls uname(2) syscall.

-- 
Alex

----------------------------------------------------------------------
 Excellent.. now give users the option to cut your hair you hippie!
                                                  -- Anonymous Coward

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
