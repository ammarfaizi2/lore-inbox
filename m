Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSLPOru>; Mon, 16 Dec 2002 09:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSLPOru>; Mon, 16 Dec 2002 09:47:50 -0500
Received: from smtp-server4.tampabay.rr.com ([65.32.1.43]:19694 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S263977AbSLPOrs>; Mon, 16 Dec 2002 09:47:48 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <root@chaos.analogic.com>, "Brian Jackson" <brian-kernel-list@mdrx.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo and hyperthreading
Date: Mon, 16 Dec 2002 09:56:27 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJIELIDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.3.95.1021216090324.20273A-100000@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Johnson asked:
> How do you know this? How can I learn what Windows does with
> Win/2000/professional?

Run the Windows Task Manager and selected the Performance tab; on my system,
it shows two separate graphs, one for each logical CPU.

> if two CPUs are present...." Direct quote. If you have two logical

> CPUs, you can't remove one, therefore, unless M$ has fixed the problem(s)
> in XP, you can't use Windows with two logical CPUs, i.e., hyperthreading.

The machine came with Windows XP pre-installed; I ran it a couple of times,
then blew it away (do I hear cheers?) when I installed Linux. I probably
didn't run it long-enough to hit any bugs.

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

