Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSEMOeL>; Mon, 13 May 2002 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSEMOeG>; Mon, 13 May 2002 10:34:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37137 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313698AbSEMOeC>; Mon, 13 May 2002 10:34:02 -0400
Date: Mon, 13 May 2002 11:32:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: Zlatko Calusic <zlatko.calusic@iskon.hr>, Bill Davidsen <davidsen@tmr.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] IO wait accounting
In-Reply-To: <AAEGIMDAKGCBHLBAACGBCEDDCIAA.balbir.singh@wipro.com>
Message-ID: <Pine.LNX.4.44L.0205131131380.32261-200000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="----=_NextPartTM-000-aabc047b-6650-11d6-a942-00b0d0d06be8"
Content-ID: <Pine.LNX.4.44L.0205131131381.32261@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------=_NextPartTM-000-aabc047b-6650-11d6-a942-00b0d0d06be8
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0205131131382.32261@imladris.surriel.com>

On Mon, 13 May 2002, BALBIR SINGH wrote:

> http://sunsite.uakom.sk/sunworldonline/swol-08-1997/swol-08-insidesolaris.html
>
> Simple and straight forward implementation of a per-cpu iowait statistics
> counter.

Hehe, so straight forward that I already did this part last
week, before searching around for papers like this.

At least it means the stats will be fully compatible and
sysadmins won't get lost (like they do with the different
meanings of the load average).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

------=_NextPartTM-000-aabc047b-6650-11d6-a942-00b0d0d06be8
Content-Type: TEXT/PLAIN; NAME="Wipro_Disclaimer.txt"
Content-ID: <Pine.LNX.4.44L.0205131131383.32261@imladris.surriel.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="Wipro_Disclaimer.txt"

**************************Disclaimer************************************
      


Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.



 ********************************************************************

------=_NextPartTM-000-aabc047b-6650-11d6-a942-00b0d0d06be8--
