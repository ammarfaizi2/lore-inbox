Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWX7x>; Thu, 23 Nov 2000 18:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKWX7d>; Thu, 23 Nov 2000 18:59:33 -0500
Received: from quechua.inka.de ([212.227.14.2]:16146 "EHLO mail.inka.de")
        by vger.kernel.org with ESMTP id <S129097AbQKWX7Z>;
        Thu, 23 Nov 2000 18:59:25 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-Id: <E13z5nt-0007ig-00@calista.inka.de>
Date: Fri, 24 Nov 2000 00:29:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14874.25691.629724.306563@wire.cadcamlab.org> you wrote:
> This is mostly a heads-up to say that in this regard gcc is not ready
> for prime time, so we really can't get away with using if() as an ifdef
> yet, at least not without penalty.

Humm.. whats the Advantage of this?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
