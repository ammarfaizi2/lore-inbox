Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289371AbSAVTkU>; Tue, 22 Jan 2002 14:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSAVTkA>; Tue, 22 Jan 2002 14:40:00 -0500
Received: from [216.70.178.182] ([216.70.178.182]:14084 "EHLO mail.xinetd.com")
	by vger.kernel.org with ESMTP id <S289371AbSAVTj6>;
	Tue, 22 Jan 2002 14:39:58 -0500
Date: Tue, 22 Jan 2002 11:39:57 -0800 (PST)
From: Glendon Gross <gross@xinetd.com>
To: linux-kernel@vger.kernel.org
Subject: login timeout at the console with 2.4.17 (fwd)
Message-ID: <Pine.LNX.4.21.0201221139060.844-100000@mail.xinetd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a strange problem in that I get the message "login timed out after
60 seconds" after entering the correct password at the console.  This only
happens with 2.4.17 and not with 2.2.14 when booting on the same machine
[P-II 233 Mhz.]   

I thought this might be a PAM issue but am puzzled by the fact that
the problem does not happen when booting kernel 2.2.14, so it is 
the same init scripts.  Initially this worked fine and then stopped
working, so I was wondering if someone had hacked me but I can't find
any changes to the init scripts.

Both kernels have IPv6 support and I am running iptables, but I don't 
see why that would affect things.  Does anyone have any ideas? TIA.

--Glendon Gross


