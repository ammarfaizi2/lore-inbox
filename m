Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277957AbRJOBjj>; Sun, 14 Oct 2001 21:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277962AbRJOBj3>; Sun, 14 Oct 2001 21:39:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16144 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277957AbRJOBjO>; Sun, 14 Oct 2001 21:39:14 -0400
Subject: Re: [RFC] "Text file busy" when overwriting libraries
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 15 Oct 2001 02:44:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <m13d4mq77d.fsf@frodo.biederman.org> from "Eric W. Biederman" at Oct 14, 2001 02:48:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15swoM-0000de-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We already can open an exec only file just open("file", 0).

Wrong.

> In fact it looks like you can open a file with no permissions at all.
> You just can't do anything with it.

This isnt true. Read the code.

Alan
