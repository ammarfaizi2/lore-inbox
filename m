Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269570AbRHLXf3>; Sun, 12 Aug 2001 19:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269571AbRHLXfT>; Sun, 12 Aug 2001 19:35:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55056 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269570AbRHLXfL>; Sun, 12 Aug 2001 19:35:11 -0400
Subject: Re: Linux 2.4.8-ac2
To: sgoethel@jausoft.com (Sven Goethel)
Date: Mon, 13 Aug 2001 00:37:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Sven Goethel" at Aug 13, 2001 01:30:40 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15W4nB-0006RQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i just want to ask you (sorry for this consumer behavior)
> if you intend to integrate the xfs filesystem in your ac-series

I've discussed it with Martin Petersen a bit. Its not clear it makes
sense, since they kind of do chunks of their own vm (partly because they
had to) and other bits like acls that want to be out for the first one.
Right no I don't know what will occur. I think in part it depends when
Linus starts 2.5

> also .. do you know if it is planed to integrate the xfs fs
> into the main branch of the kernel ?

You'd have to ask Linus

