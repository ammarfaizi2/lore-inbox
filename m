Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSH1R2b>; Wed, 28 Aug 2002 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSH1R2b>; Wed, 28 Aug 2002 13:28:31 -0400
Received: from christpuncher.kingsmeadefarm.com ([209.216.78.83]:62893 "HELO
	the-grudge.myip.org") by vger.kernel.org with SMTP
	id <S318020AbSH1R2a>; Wed, 28 Aug 2002 13:28:30 -0400
Message-ID: <1030555971.3d6d09430f774@webmail.kingsmeadefarm.com>
Date: Wed, 28 Aug 2002 13:32:51 -0400
From: Joe Kellner <jdk@kingsmeadefarm.com>
To: linux-kernel@vger.kernel.org
Subject: e1000 strangeness in a dell poweredge 1650
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 64.156.25.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
Running a dell poweredge 1650 with two intel e1000/pro's on redhat 7.3.
We seem to be having a problem with the ethernet cards linking at 100 mbps/FDX 
and only working for a few seconds (usually around 30 seconds). There are no 
messages in dmesg other than when the module is loaded (Stating that port0 is 
up at 100 mbs/FDX). Is this a known issue, and is there a workaround? I can 
provide more information if needed.


Thanks,
-Joe Kellner

-------------------------------------------------
sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
