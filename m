Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSEQSSx>; Fri, 17 May 2002 14:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSEQSSw>; Fri, 17 May 2002 14:18:52 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:41488 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316636AbSEQSSv>;
	Fri, 17 May 2002 14:18:51 -0400
To: linux-kernel@vger.kernel.org
Subject: ide cd/dvd with 2.4.19-pre8
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 17 May 2002 20:18:49 +0200
Message-ID: <yw1x1ycak586.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that reading from both my cdrom and dvd is a lot slower
with 2.4.19-pre8 than 2.4.18. Now hdparm reports ~800 kbytes/s compared to
1.7 MBytes/s for CD and >2 MBytes/s for DVD with 2.4.18. It is even impossible
to play DVDs. Any ideas?

-- 
Måns Rullgård
mru@users.sf.net
