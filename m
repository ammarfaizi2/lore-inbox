Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282695AbRLOPEI>; Sat, 15 Dec 2001 10:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLOPD7>; Sat, 15 Dec 2001 10:03:59 -0500
Received: from sushi.toad.net ([162.33.130.105]:4808 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S282695AbRLOPDo>;
	Sat, 15 Dec 2001 10:03:44 -0500
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 10:03:42 -0500
Message-Id: <1008428624.4934.38.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What on earth are you talking about, this is completely
> unrelated to what this message is about. ide-scsi didn't
> set the right vec count for the submitted bio, so dma
> transfers barfed on irq timeout.

I like the sound of that!    Hmm ...

The vec count is not set by
ide-scsi for submitted bi
o.

So,
on the timing out ir
q the dma transfar
doth barf.


