Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbSJKJoc>; Fri, 11 Oct 2002 05:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJKJoc>; Fri, 11 Oct 2002 05:44:32 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4261 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262374AbSJKJob>; Fri, 11 Oct 2002 05:44:31 -0400
Message-Id: <4.3.2.7.2.20021011115225.00c5f480@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 11 Oct 2002 11:55:31 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <RogerWhile@sim-basis.de>
Subject: MTRR and SERVERWORKS
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: RogerWhile@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is MTRR disabled for SERVERWORKS chipset ?
It works fine on my Asus CUR-DLS after commenting the code out. (2.4 and 
2.5)
Can we at least make it configurable ?


