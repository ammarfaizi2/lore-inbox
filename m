Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSJRLF1>; Fri, 18 Oct 2002 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSJRLF1>; Fri, 18 Oct 2002 07:05:27 -0400
Received: from mx6.mail.ru ([194.67.57.16]:48908 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id <S265063AbSJRLF0>;
	Fri, 18 Oct 2002 07:05:26 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5 and lowmemory boxens
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Fri, 18 Oct 2002 15:11:13 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E182V29-000Pfa-00@f15.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.

 the one problem was the ppp over serial not working, but i suspect
 that it just needs to be recompiled with 2.5 headers (am i right?).

 the other was, well, the fact that ultra-stripped 2.5.43
 still used 200k more memory than 2.4.19, and thats despite it was
 compiled with -Os instead of -O2.
 actually it was 2000k free with 2.4 vs 1800k  free with 2.5

 i know Rik had plans of some ultra bloody embedded/lowmem
 changes for such cases. i`d like to hear about things in the area :)

regards, Samium Gromoff, aka Serge Kosyrev

