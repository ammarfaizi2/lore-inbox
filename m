Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFM7J>; Wed, 6 Dec 2000 07:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130469AbQLFM67>; Wed, 6 Dec 2000 07:58:59 -0500
Received: from diuna.pingwin.waw.pl ([195.117.106.132]:9993 "EHLO
	diuna.pingwin.waw.pl") by vger.kernel.org with ESMTP
	id <S129423AbQLFM6n>; Wed, 6 Dec 2000 07:58:43 -0500
Date: Wed, 6 Dec 2000 13:33:20 +0100
From: Wojtek Piecek <woju@pingwin.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: hang while reading from loopback
Message-ID: <20001206133320.A9335@diuna.pingwin.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to cp-ing file from loopback-mounted CD using kernel 2.4.0-test12-pre5
and -pre6 kernel hard hang. SysRq can't help.

With 2.4.0-test11-ac4 is OK.

--w
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
