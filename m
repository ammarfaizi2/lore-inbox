Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSHJJdp>; Sat, 10 Aug 2002 05:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSHJJdp>; Sat, 10 Aug 2002 05:33:45 -0400
Received: from [210.78.134.243] ([210.78.134.243]:58372 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S316709AbSHJJdo>;
	Sat, 10 Aug 2002 05:33:44 -0400
Date: Sat, 10 Aug 2002 17:38:39 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: about the tuning of eepro100
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200208101742654.SM00824@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



i have been tuning the performance of eepro100 these days. we tested linux router with smartbits. our router has two PIII800 CPU,512M ram. 
kernel version is 2.4.19-pre1. the driver is e100.
in the test,we found that the throughput of 64bytes frames is 61%. that's about 90kpps. then we tuned almost all the parameters the e100 driver applied, but could not get higher results.
so i think the limit is at the eepro100 card. is there any way to improve the throughput? or someone got a higher throughput then that?
the eepro100 chip is 82559.
please cc. thanks.

regards,
chuanbo zheng
zhengcb@netpower.com.cn


