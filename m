Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131956AbQKVQdk>; Wed, 22 Nov 2000 11:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131979AbQKVQda>; Wed, 22 Nov 2000 11:33:30 -0500
Received: from adsl-63-205-85-133.dsl.snfc21.pacbell.net ([63.205.85.133]:18193
        "EHLO schmee.sfgoth.com") by vger.kernel.org with ESMTP
        id <S131956AbQKVQdY>; Wed, 22 Nov 2000 11:33:24 -0500
Date: Wed, 22 Nov 2000 08:03:18 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [PATCH] atmrefcount
Message-ID: <20001122080318.A53983@sfgoth.com>
In-Reply-To: <Pine.LNX.4.21.0011221029020.995-100000@panoramix.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0011221029020.995-100000@panoramix.bitwizard.nl>; from patrick@bitwizard.nl on Wed, Nov 22, 2000 at 10:31:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick van de Lageweg wrote:
> This patch contains the fix for the atmrefcount problem (noted as a
> critical problem in Ted's todo list). It also has the makefile
> modifications for the firestream driver in a separate email. 

Could you please split the two patches so that they're actually independant
(i.e. put all the stuff for the new driver in its own patch).  I'll
comment on that driver seperately.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
