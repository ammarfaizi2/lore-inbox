Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSBGMMd>; Thu, 7 Feb 2002 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSBGMMX>; Thu, 7 Feb 2002 07:12:23 -0500
Received: from dc-mx07.cluster0.hsacorp.net ([209.225.8.17]:64190 "EHLO
	dc-mx07.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S287513AbSBGMMO>; Thu, 7 Feb 2002 07:12:14 -0500
Message-Id: <3.0.3.32.20020207061216.00ddc628@pop.charter.net>
X-Mailer: QUALCOMM Windows Eudora Pro Version 3.0.3 (32)
Date: Thu, 07 Feb 2002 06:12:16 -0600
To: "David S. Miller" <davem@redhat.com>
From: Pete Cervasio <cervasio@charter.net>
Subject: Re: ?????????????????????
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020207.034425.98342188.davem@redhat.com>
In-Reply-To: <20020207201243.26395f39.bruce@ask.ne.jp>
 <2094646627.1013034678@[195.224.237.69]>
 <0GR400HBLXT5DU@mtaout03.icomcast.net>
 <20020207201243.26395f39.bruce@ask.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:44 AM 2/7/2002 -0800, David S. Miller <davem@redhat.com> wrote:
>   From: Bruce Harada <bruce@ask.ne.jp>
>   Date: Thu, 7 Feb 2002 20:12:43 +0900
>
>   On Wed, 06 Feb 2002 18:42:17 -0500
>   Brian <hiryuu@envisiongames.net> wrote:
>   
>   > To my knowledge, there is no English word that would match that regex
(or, 
>   > for that matter, any Romantic or Germanic language word).  It's the
most 
>   > effective tool I've seen against Asian spam (like the one I replied to).
>   
>   Just to set the record straight, that was RUSSIAN spam, not Asian spam...
>   (The regex should still be effective, of course.)
>
>Except that it would block out uuencoded patches in postings perhaps?
>Or is it just supposed to be matched in the Subject field or other
>parts of the headers?

Um... no, it's just supposed to look at several characters in a row that
have the high bit set.  Have another cup of coffee and think about what
happens to attachments after they're uuencoded.  :)

Best regards,
Pete C.


=====================================================================
         $5                          $75
"this is your brain... this is your brain on ebay."
                                     (Pat McNeil on comp.sys.tandy)
