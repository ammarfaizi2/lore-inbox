Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269293AbTCDHIP>; Tue, 4 Mar 2003 02:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269294AbTCDHIP>; Tue, 4 Mar 2003 02:08:15 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:31492 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S269293AbTCDHIP>;
	Tue, 4 Mar 2003 02:08:15 -0500
To: Adam Belay <ambx1@neo.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.5-bk-current drivers/pnp/interface.c
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 04 Mar 2003 02:18:36 -0500
Message-ID: <m3smu38ur7.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw this as it was flying by on the xterm.  fwiw:

drivers/pnp/interface.c: In function `pnp_show_possible_resources':
drivers/pnp/interface.c:224: warning: implicit declaration of function `kfree'

-JimC (who is assuming linux-2.5/MAINTAINERS is up to date...)

