Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315460AbSEOODH>; Wed, 15 May 2002 10:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315799AbSEOODG>; Wed, 15 May 2002 10:03:06 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:23305 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S315460AbSEOODG>;
	Wed, 15 May 2002 10:03:06 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2
In-Reply-To: <20020515130328.GA19698@spylog.ru>
User-Agent: tin/1.5.12-20020227 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E177zMw-0000ml-00@roos.tartu-labor>
Date: Wed, 15 May 2002 17:03:06 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had similar problems with integrated AIC7850 on Digital Celebris GL 5133
ST. 2.4.19-pre7 and pre8 only tested so far, no earlier kernels tested at all.

Selecting old adaptec scsi deriver works like a charm.

AN> aic7xxx_dev_reset returns 0x2002

I had 0x2008 here IIRC. Did not capture the output because this was about the
root partition and I had no serial cable at home. Will capture it with serial
console today.

-- 
Meelis Roos (mroos@linux.ee)
