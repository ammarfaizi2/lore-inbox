Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266237AbSKOMDu>; Fri, 15 Nov 2002 07:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSKOMDu>; Fri, 15 Nov 2002 07:03:50 -0500
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:48311 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266237AbSKOMDt> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 07:03:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Error in bogomips value?
Date: Fri, 15 Nov 2002 13:08:43 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211151308.43830.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

checking the bogomips return value from my dual Xeon 2.4 box ...

[root@superman squid]# grep ^bog /proc/cpuinfo
bogomips        : 4771.02
bogomips        : 4784.12
bogomips        : 4784.12
bogomips        : 4784.12

Why is the first logical cpu "slower" than the other ones?
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

