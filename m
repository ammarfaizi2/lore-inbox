Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272797AbRIGSCU>; Fri, 7 Sep 2001 14:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272798AbRIGSCL>; Fri, 7 Sep 2001 14:02:11 -0400
Received: from infinity.ciit.y12.doe.gov ([134.167.144.20]:28435 "EHLO
	infinity.ciit.y12.doe.gov") by vger.kernel.org with ESMTP
	id <S272797AbRIGSBv>; Fri, 7 Sep 2001 14:01:51 -0400
Message-ID: <3B990B9D.EBF95D73@ciit.y12.doe.gov>
Date: Fri, 07 Sep 2001 14:02:05 -0400
From: Lawrence MacIntyre <lpz@ciit.y12.doe.gov>
Organization: Center for Information Infrastructure Technology
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-SGI_XFS_1.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hamachi (GNIC-II) and 2.4.9-ac9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hola:

2.4.4 was only trivially different from 2.4.3 so I skipped it.  2.4.5
was fine.  2.4.6 worked, but it lost a bit over 10 Mb/s in transmit
speed.  2.4.7 is broken.  I only tested on the alpha.

> except that the hamachi won't work.  ifconfig shows no packets received,
> but some errors, there are no strange messages in /var/log/messages.  I
> then built the same kernel on the intel box, and the same thing

Curious. There are no hamachi driver differences between 2.4.9 and
2.4.9-ac
so the obvious question is which was the last version it did work ?
-- 
                                 Lawrence
                                    ~
------------------------------------------------------------------------
 Lawrence MacIntyre    Center for Information Infrastructure Technology
 865.574.8696   lpz@ciit.y12.doe.gov   http://www.ciit.y12.doe.gov/~lpz
