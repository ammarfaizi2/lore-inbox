Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277365AbRJOJ40>; Mon, 15 Oct 2001 05:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277366AbRJOJ4Q>; Mon, 15 Oct 2001 05:56:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34833 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277365AbRJOJ4E>; Mon, 15 Oct 2001 05:56:04 -0400
Subject: Re: how to let audio work on intel i810
To: wqb123@yahoo.com (Barry Wu)
Date: Mon, 15 Oct 2001 11:02:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011015093240.93914.qmail@web13907.mail.yahoo.com> from "Barry Wu" at Oct 15, 2001 02:32:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15t4Zt-0001gY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have installed redhat7.1 on my intel i810
> system. But the audio can not work. Does
> it need some patches? If someone knows, please
> help me. Thanks.

It should just work. Can you try the RH 7.1 errata kernel and if that
also gives you the problem having run "sndconfig" can you file a bug
report in
	https://bugzilla.redhat.com/bugzilla

