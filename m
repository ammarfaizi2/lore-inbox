Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSEAXZX>; Wed, 1 May 2002 19:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSEAXZW>; Wed, 1 May 2002 19:25:22 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:11736 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id <S314123AbSEAXZU>;
	Wed, 1 May 2002 19:25:20 -0400
Message-ID: <000c01c1f167$75d36bc0$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020501191715.A26798@rushmore>
Subject: block a thread in kernel, thanks alot
Date: Wed, 1 May 2002 18:25:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I expicitly block a thread in kernel?  For example, I can use
wake_up_process(task) to wakeup (and put to runqueue). How to block task, if
I do not want it to run? Thanks a lot

