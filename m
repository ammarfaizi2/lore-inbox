Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLRXae>; Mon, 18 Dec 2000 18:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLRXaY>; Mon, 18 Dec 2000 18:30:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129595AbQLRXaH>; Mon, 18 Dec 2000 18:30:07 -0500
Subject: Re: generic sleeping locks?
To: eli.carter@inet.com (Eli Carter)
Date: Mon, 18 Dec 2000 23:01:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A3E95B3.19E51EEE@inet.com> from "Eli Carter" at Dec 18, 2000 04:54:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1489Hp-0006Ms-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there blocking lock primitives already defined somewhere in the
> kernel?

down and up are normally appropriate for this

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
