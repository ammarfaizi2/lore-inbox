Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbRFBWG4>; Sat, 2 Jun 2001 18:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbRFBWGq>; Sat, 2 Jun 2001 18:06:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5905 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261783AbRFBWG1>; Sat, 2 Jun 2001 18:06:27 -0400
Subject: Re: Date goes four times faster!
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 2 Jun 2001 23:04:12 +0100 (BST)
Cc: sunqw@ns.lzb.ac.cn (Sun Qingwei), bug-sh-utils@gnu.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010602134003.A183@bug.ucw.cz> from "Pavel Machek" at Jun 02, 2001 01:40:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156JVE-0002DL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This noon I found that the date went four times faster! It was going well
> > before about 11 PM Wen May 30. But after that the date
> 
> :-) On my system, date likes to go 3 times slower when I do heavy
> scrolling. Maybe we should teach our computers to do something in the
> middle ;-).

That is a console locking flaw. Its fixed in the -ac series

