Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHFRl7>; Tue, 6 Aug 2002 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSHFRl7>; Tue, 6 Aug 2002 13:41:59 -0400
Received: from [213.4.129.129] ([213.4.129.129]:24415 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S314634AbSHFRlB>;
	Tue, 6 Aug 2002 13:41:01 -0400
Date: Tue, 6 Aug 2002 19:16:41 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: pppd[32497]: Unsupported protocol 'CallBack Control Protocol (CBCP)' (0xc029) received
Message-Id: <20020806191641.54e96193.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In different kernels I've seen this message:

Aug  6 19:10:01 localhost pppd[32497]: Unsupported protocol 'CallBack
Control Protocol (CBCP)' (0xc029) received


Is pppd who has to handle this protocol, or it's a "ToDo" in ppp in the
kernel? In the last case, will it be implemented?

and, what's the hell is the "Callback Protocol?"

