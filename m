Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S317256AbSFGMno>; Fri, 7 Jun 2002 08:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S317276AbSFGMnn>; Fri, 7 Jun 2002 08:43:43 -0400
Received: from mx9.mail.ru ([194.67.57.19]:30994 "EHLO mx9.mail.ru") by vger.kernel.org with ESMTP id <S317256AbSFGMnn>; Fri, 7 Jun 2002 08:43:43 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD-649 support? (in a hurry - please help)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Fri, 07 Jun 2002 16:43:42 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17GJ5i-000MBg-00@f5.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yeah the Linux driver supports them, but CMD chips in general are
> > pretty buggy...

> oh. anyone around with any experience with the 649?
 --
> Roy Sigurd Karlsbakk, Datavaktmester

 i have one. 2.4.19-pre3, 1x IBM 60GXP - 1 month
or so of a stable usage.
 also it runs faster on udma66 than on udma100, but thats beyond me... ;)
 p166, 40M
         mwdma2 - 11 MB/s
         udma4 - 13.5 MB/s
         udma5 - 11.5 MB/s

---
cheers,
   Samium Gromoff

