Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSJKIIJ>; Fri, 11 Oct 2002 04:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSJKIIJ>; Fri, 11 Oct 2002 04:08:09 -0400
Received: from mx7.mail.ru ([194.67.57.17]:44044 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S262416AbSJKIII>;
	Fri, 11 Oct 2002 04:08:08 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: More on O_STREAMING (goodby read pauses)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Fri, 11 Oct 2002 12:13:50 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17zuve-0008v9-00@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   So i suspect this O_STREAMING will revive the disk->disk
 data copying transfer rate for large files like these bloody
 mpeg4 .avi`s ;)

   Disk transfers depends on the drive being constantly busy
 and this new report from the battlefield brings a new hope.

   The only thing left is to adopt the userland tools
 like cp and mc...

---
cheers,
   Samium Gromoff
_________________________________
_____________________________________

