Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRA3Oay>; Tue, 30 Jan 2001 09:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRA3Oao>; Tue, 30 Jan 2001 09:30:44 -0500
Received: from h0000f8512160.ne.mediaone.net ([24.128.252.23]:57082 "EHLO
	dragon.universe") by vger.kernel.org with ESMTP id <S130362AbRA3Oah>;
	Tue, 30 Jan 2001 09:30:37 -0500
Date: Tue, 30 Jan 2001 09:30:36 -0500
From: newsreader@mediaone.net
To: linux-kernel@vger.kernel.org
Subject: klogd is acting strange with 2.4
Message-ID: <20010130093035.A31970@dragon.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

celeron 433 intel i810.  320MB ram.

Before 2.2.18.  Now I've tested with both
2.4.1-pre12 and 2.4.1.  2.4 kernel klogd is
always using 99% cpu.  What gives?

I've three other less powerful boxes running
2.4.x kernels and none of them behave
like this.  This server isn't taking any
more hits than it usually does.

What more information I should post here?
I've two apache servers, pgsql and sendmail
and some other processes running on this
server.

Thanks in advance
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
