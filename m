Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSIFDiZ>; Thu, 5 Sep 2002 23:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSIFDiZ>; Thu, 5 Sep 2002 23:38:25 -0400
Received: from [210.78.134.243] ([210.78.134.243]:64781 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S318259AbSIFDiY>;
	Thu, 5 Sep 2002 23:38:24 -0400
Date: Fri, 6 Sep 2002 11:46:3 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem with eepro100 on cisco 2950
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200209061150844.SM00836@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we have a eepro100 card on our linux system. we build an IDS on the system. the problem is when  we use the system on the monitor port of cisco 2950,it could not sniffer any packets. we made some test on the monitor ports of other kinds of cisco swithes,all worked well.when applied on hubs,it also worked well.
we tried rtl8139 on cisco 2950, it worked well.
so what's the problem? the driver? or the 2950 switch?

please cc. thanks. 

zhengchuanbo
zhengcb@netpower.com.cn

