Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136094AbRDVNA5>; Sun, 22 Apr 2001 09:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136097AbRDVNAr>; Sun, 22 Apr 2001 09:00:47 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:39299 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S136094AbRDVNAg>; Sun, 22 Apr 2001 09:00:36 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: junio@siamese.dhis.twinsun.com, manuel@mclure.org (Manuel McLure),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sun, 22 Apr 2001 13:54:28 BST." <E14rJNn-0005mh-00@the-village.bc.nu> 
In-Reply-To: <E14rJNn-0005mh-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 14:00:19 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14rJTP-0005jL-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Why ? It works in the 2.96 snapshots. So 2.96+ is fine.
>> 
>> GCC snapshots have called themselves 2.97 since last September.  "2.96" just
>> means that it's some random old version.  Yours happens to work; there's no 
>> guarantee that everybody else's will too.
>
>2.97+ are also all random snapshots most of which dont actually work. Im 
>obviously missing a point here.

Are you being deliberately obtuse?  2.97+ snapshots do all support 
builtin_expect, which is what we were discussing.

p.


