Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131524AbQK2OjO>; Wed, 29 Nov 2000 09:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131532AbQK2Oiy>; Wed, 29 Nov 2000 09:38:54 -0500
Received: from 213-123-77-81.btconnect.com ([213.123.77.81]:59652 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131524AbQK2Oir>;
        Wed, 29 Nov 2000 09:38:47 -0500
Date: Wed, 29 Nov 2000 14:10:16 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <UTC200011291344.OAA150800.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.21.0011291408470.974-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:

> I just tried 2.4.0test12pre3, which has Jens' fix,
> and no corruption to be seen. Will test a bit more,
> but perhaps this did it.
> 

I have also been testing very hard on the SMP (4xXeon/6G) machine with
test12-pre3 and also cannot reproduce the problem. This is a SCSI-only
machine and I don't know what Jens' fix is and whether it is applicable or
not.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
