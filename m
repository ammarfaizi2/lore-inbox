Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRELXFj>; Sat, 12 May 2001 19:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbRELXF3>; Sat, 12 May 2001 19:05:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22547 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261336AbRELXFT>; Sat, 12 May 2001 19:05:19 -0400
Subject: Re: Athlon possible fixes
To: ishikawa@yk.rim.or.jp (Ishikawa)
Date: Sun, 13 May 2001 00:02:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AFD817A.AD5B2160@yk.rim.or.jp> from "Ishikawa" at May 13, 2001 03:31:22 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yiOe-0004ae-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was a little skeptical to think that the X11 server code
> has such a bug for SVGA 16bits color server today,
> and yet was still wondering if

Corner cases could exist. If you can replicate it the X folks will be most
interested I suspect.
> 
> But can the same problem manifest on AMD 751 chipset?
> That would explain this mysterious X11 server
> crash beatifully :-)

The X server doesnt use prefetch instructions...

