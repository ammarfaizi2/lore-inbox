Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSEYJsg>; Sat, 25 May 2002 05:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSEYJsf>; Sat, 25 May 2002 05:48:35 -0400
Received: from imo-r10.mx.aol.com ([152.163.225.106]:29664 "EHLO
	imo-r10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S314409AbSEYJse>; Sat, 25 May 2002 05:48:34 -0400
From: Floydsmith@aol.com
Message-ID: <3a.2744d23a.2a20b7ec@aol.com>
Date: Sat, 25 May 2002 05:48:28 EDT
Subject: can't find startup messages since april in /var/log/messages using 2.4.18
To: linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 7.0 for Windows US sub 10512
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some strange reason I can't find where my "startup messagges" are being 
stored. I booted up twice this morning (052502) and only get only 1 line in 
/var/log/messages which is:
May 25 05:10:05 localhost syslogd 1.3-3: restart.

All boots since April 11 have only one such entry recorded. "dmesg" and a 
"vi" of "messages" show a full log journal for April 11.
I have did a "df" and all file sytems have free space.

Of course, the meesages do appear on the console at startup.

Any suggestions?

Floyd,

