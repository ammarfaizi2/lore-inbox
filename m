Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319237AbSIEX1z>; Thu, 5 Sep 2002 19:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319397AbSIEX1z>; Thu, 5 Sep 2002 19:27:55 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:59888
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319237AbSIEX1x>; Thu, 5 Sep 2002 19:27:53 -0400
Subject: Re: IDE support for suspend -- prevent data corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, alan@redhat.com,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020905230605.GA26735@elf.ucw.cz>
References: <20020905230605.GA26735@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:33:21 +0100
Message-Id: <1031268801.7834.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 00:06, Pavel Machek wrote:
> Hi!
> 
> Doing suspend/resume without device support in disk drivers is asking
> for e2fsck test. Please apply this to add device support back to
> ide. [Ported patches from 2.5.31 and tested a bit.] Please apply,

Start from the 2.5.33 IDE and feed the change past Andre and Al Viro.


