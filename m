Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSINSQd>; Sat, 14 Sep 2002 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSINSQd>; Sat, 14 Sep 2002 14:16:33 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:26041 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317399AbSINSQc>; Sat, 14 Sep 2002 14:16:32 -0400
Message-ID: <3D837EB5.5040703@jimbrooks.org>
Date: Sat, 14 Sep 2002 11:23:49 -0700
From: Jim Brooks <linuxml@jimbrooks.org>
Reply-To: linuxml@jimbrooks.org
Organization: jimbrooks.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre5-ac3 IDE CDRW panic (reproducible)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.20-pre5 + ac3 + preemptible.

The kernel panicked when I tried to install a RPM file
from an IDE CDRW writer drive.  I tried merely copying
a file from the CD writer -- that panicked too.

What is peculiar about my PC is that it has two IDE CD drives:
CDRW and CDR (and it is dual x86).

The panic is reproducible, and doesn't appear on kernel 2.4.8
nor when I use the CDR (read-only) drive.

--
Jim Brooks  http://www.jimbrooks.org

