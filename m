Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317062AbSEXBB0>; Thu, 23 May 2002 21:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317061AbSEXBBZ>; Thu, 23 May 2002 21:01:25 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:9628 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317060AbSEXBBZ> convert rfc822-to-8bit; Thu, 23 May 2002 21:01:25 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-preX and DRM Modules? Evil old!! why?
Date: Fri, 24 May 2002 02:51:11 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205240251.11689.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

please can anyone tell me why XFree DRM Modules aren't updated to the latest 
version in 2.4.19-pre8 ? There is a new version out since January 2002. 
2.4.19-preX still stucks on the old DRM engine and you have to manually 
compile the according modules to use XFree 4.2.0, otherwise you won't get DRI 
support.

If there is any interest in this, i will send a patch applying clean on 
2.4.19-pre8. With this you don't have to compile the extra package by hand 
and you can use XFree 4.2.0 with DRI support by kernel modules.

Alan has this patches in his tree a long time, also i have the patches in my 
tree wolk, running fine.

So? apply or not apply, that's the question ;)

-- 
Kind regards,
	Marc


