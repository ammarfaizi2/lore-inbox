Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264145AbRFNWvi>; Thu, 14 Jun 2001 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbRFNWv2>; Thu, 14 Jun 2001 18:51:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27664 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264145AbRFNWvP>; Thu, 14 Jun 2001 18:51:15 -0400
Subject: Re: 2.4.5 data corruption
To: crosser@average.org (Eugene Crosser)
Date: Thu, 14 Jun 2001 23:49:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9gbdoa$cpi$1@pccross.average.org> from "Eugene Crosser" at Jun 15, 2001 02:27:22 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Afvk-0005aV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> any problems since 2.4.5 was published, they seem to have surfaced
> immediately after I created a rather big file capturing video with
> broadcast2000 (video card is bt848).  Filesystem is ext2.

Thats something I've seen reported elsehwere. The high bandwidth capture card
stuff seems to show up problems. It could be drivers could be hardware. On
my AMD 751 pre release board I see that problem but on the 751 production board
I dont
