Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132628AbRDGLkp>; Sat, 7 Apr 2001 07:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDGLk0>; Sat, 7 Apr 2001 07:40:26 -0400
Received: from mlist.austria.eu.net ([193.81.83.3]:39149 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132628AbRDGLkQ>; Sat, 7 Apr 2001 07:40:16 -0400
Message-ID: <3ACEFC84.AF9479B6@eunet.at>
Date: Sat, 07 Apr 2001 13:39:48 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ISIcom cards by Multi-tech
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

who is maintaining the isicom driver? A customer of mine uses such a
card in a linux server, when we upgraded from kernel 2.0 to 2.4.3 this
week, there have been some minor problems with this card.

There is a driver in the official 2.4 tree, but it seems quite old.
There are newer drivers at the multitech homepage, but only for kernel
2.2. Especially one new feature (resetting the card; from time to time
the card stucks and could only be resetted by rebooting) looks very
important to me.

As multitech seems not to provide a driver for 2.4, someone must have
ported the 2.2 driver to 2.4. I'd like to talk to this person, and help
merging the 2.2 updates to 2.4.

TIA, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
