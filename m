Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSIAOrG>; Sun, 1 Sep 2002 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSIAOrG>; Sun, 1 Sep 2002 10:47:06 -0400
Received: from [62.70.77.106] ([62.70.77.106]:45995 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317096AbSIAOrF> convert rfc822-to-8bit;
	Sun, 1 Sep 2002 10:47:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: O_DIRECT for ext3 in 2.4.20?
Date: Sun, 1 Sep 2002 16:54:47 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209011654.47705.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I got this patch from akpm with o_direct support in ext3. I've tested it quite 
a lot with read, but not much write (only batches).

Any chance to get this sneaked into 2.4.20?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

