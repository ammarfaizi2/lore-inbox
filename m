Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279618AbRJXWQ3>; Wed, 24 Oct 2001 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279619AbRJXWQT>; Wed, 24 Oct 2001 18:16:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279618AbRJXWQO>; Wed, 24 Oct 2001 18:16:14 -0400
Subject: Re: status of supermount?
To: jonas@berlin.vg (Jonas Berlin)
Date: Wed, 24 Oct 2001 23:22:59 +0100 (BST)
Cc: swalker@fs1.theiqgroup.com (Shawn Walker),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20011024200049.A20340@niksula.hut.fi> from "Jonas Berlin" at Oct 24, 2001 08:00:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWQN-0002oq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no idea if anyone else has done anything similar. Personally I
> initially found this patch as a part of the standard kernel provided by
> mandrake 7.2 (most likely), but I don't know whether they have it in there

The Mandrake folks (Juan in paticular I believe) have been doing this work.
Alternatively you can do the same kind of stuff in userspace now thanks
to Al Viro's mount cleanups.

Take a look at volumagic on ftp://ftp.linux.org.uk/pub/linux/alan/..

its strictly a proof of concept
