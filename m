Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbRESOH1>; Sat, 19 May 2001 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbRESOHS>; Sat, 19 May 2001 10:07:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261806AbRESOHE>; Sat, 19 May 2001 10:07:04 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 19 May 2001 15:02:47 +0100 (BST)
Cc: clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> from "Alexander Viro" at May 19, 2001 04:30:09 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1517Jf-0008PV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ioctls are evil, period. At least with these names you can use normal
> scripting and don't need any special tools. Every ioctl means a binary
> that has no business to exist.

That is not IMHO a rational argument. It isn't my fault that your shell does
not support ioctls usefully. If you used perl as your login shell you would
have no problem there.

Alan


