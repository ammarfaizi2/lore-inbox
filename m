Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272966AbRIULJo>; Fri, 21 Sep 2001 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273302AbRIULJf>; Fri, 21 Sep 2001 07:09:35 -0400
Received: from ns.ithnet.com ([217.64.64.10]:6930 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272966AbRIULJX>;
	Fri, 21 Sep 2001 07:09:23 -0400
Date: Fri, 21 Sep 2001 13:09:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre13 still problems with tty_register_ldisc export
Message-Id: <20010921130945.2eed67d6.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_async.o
depmod:         tty_register_ldisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_synctty.o
depmod:         tty_register_ldisc

Regards,
Stephan
