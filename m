Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318956AbSHFBRC>; Mon, 5 Aug 2002 21:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318953AbSHFBRC>; Mon, 5 Aug 2002 21:17:02 -0400
Received: from [210.78.134.243] ([210.78.134.243]:10509 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S318940AbSHFBRB>;
	Mon, 5 Aug 2002 21:17:01 -0400
Date: Tue, 6 Aug 2002 9:22:16 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: how to filter out teardrop in linux2.4
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200208060926128.SM00816@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i use linux2.4 as a router. when i tested the device i found that teardrop packets can penetrate the router. i remember that in linux2.2 there is a defragmant option. that can filter out the teardrop packets. but i think in linux2.4 the defragmen is action in default.
i tried the -f option in iptables,but that also could not stop the teardrop packets.
so how to filter out teardrop packets in linux2.4?
please cc. thanks.

regards,
chuanbo zheng
zhengcb@netpower.com.cn

