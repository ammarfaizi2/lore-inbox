Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSIJR4o>; Tue, 10 Sep 2002 13:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSIJR4o>; Tue, 10 Sep 2002 13:56:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:47838 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317073AbSIJR4n>; Tue, 10 Sep 2002 13:56:43 -0400
Message-ID: <000d01c258fb$8cf72d40$0242a8c0@alpha.de>
From: "Frank Peters" <frank.peters@intralab.de>
To: <linux-kernel@vger.kernel.org>
Subject: ptrace probs?
Date: Tue, 10 Sep 2002 19:54:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.18  
  
If I ptrace-Attach to some program I cannot immediately peek values!  
( I can but they are all 0) if I insert a sleep(1) after the ATTACH  
it works?  
  
Can somebody explain?  
  
Frank


