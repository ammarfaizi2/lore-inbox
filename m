Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293621AbSCATCm>; Fri, 1 Mar 2002 14:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293622AbSCATCY>; Fri, 1 Mar 2002 14:02:24 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46349 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293621AbSCATCH>; Fri, 1 Mar 2002 14:02:07 -0500
Message-ID: <3C7FCFFB.2060906@evision-ventures.com>
Date: Fri, 01 Mar 2002 20:01:15 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] small proposal.
In-Reply-To: <Pine.LNX.4.33.0203010838360.3798-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the following patch would rather serve an obvious
purpose, and wonder why it didn't occur to anybody before.
Please apply it :-).

--- MAINTAINERS.orig	Fri Mar  1 19:41:17 2002
+++ MAINTAINERS	Fri Mar  1 19:46:53 2002
@@ -54,6 +54,9 @@
  so much easier [Ed]

  P: Person
+U: The name of the person in UTF-7, if different from the above
+I: contact languages applicable to the person in LOCALE-alike encoding
+   (for example: pl_PL.ISO8859-2 ru_RU.KOI8-R)
  M: Mail patches to
  L: Mailing list that is relevant to this area
  W: Web-page with status/info

