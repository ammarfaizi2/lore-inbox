Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319570AbSH3Obe>; Fri, 30 Aug 2002 10:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319573AbSH3Obe>; Fri, 30 Aug 2002 10:31:34 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:52228 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S319570AbSH3Obe>;
	Fri, 30 Aug 2002 10:31:34 -0400
From: Meelis Roos <mroos@tartu.cyber.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
In-Reply-To: <Pine.LNX.4.44.0208292051520.25834-100000@ondatra.tartu-labor>
User-Agent: tin/1.5.13-20020703 ("Chop Suey!") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E17kmrJ-0002Id-00@roos.tartu-labor>
Date: Fri, 30 Aug 2002 17:34:49 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> I have an old computer (from 1997), K6/200 with 430TX chipset. It has 
MR> served me well so far. It ran 2.4.18 OK since February. But 2.4.19 and 
MR> 2.4.20-pre5 both hang frequently. 2.2.15 works well but it looks to be 
MR> running in PIO mode. 2.4.18 ran in udma33 mode but maybe the computer is 
MR> broken now.

Additional information: 2.4.18 works well, 2.5.32 hangs too.

So the hardware is probably OK and 2.4.19/20pre are broken :(

-- 
Meelis Roos (mroos@tartu.cyber.ee)
