Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135398AbRDMEuf>; Fri, 13 Apr 2001 00:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbRDMEuZ>; Fri, 13 Apr 2001 00:50:25 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:46065 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135398AbRDMEuN>; Fri, 13 Apr 2001 00:50:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] 8139too 'too much work at interrupt'
Date: Fri, 13 Apr 2001 00:50:10 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041300501001.06447@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upgraded to ac5 tonight.  It stalled shortly after start a 
program to suck news.  Looking at a serial console I see
hundreds of the above message with a status of
intrStatus = 0x0001

Sysrq was active on the serial console so I did a T and P
before syncing are rebooting...  If the translated traces
are of any use just ask.

Ed Tomlinson <tomlins@cam.org>

