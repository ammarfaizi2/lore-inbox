Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSAaARh>; Wed, 30 Jan 2002 19:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSAaARX>; Wed, 30 Jan 2002 19:17:23 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:3590 "EHLO jubjub.wizard.com")
	by vger.kernel.org with ESMTP id <S290768AbSAaAQM>;
	Wed, 30 Jan 2002 19:16:12 -0500
Date: Wed, 30 Jan 2002 16:16:09 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: make xconfig whinges about Configure.help
Message-ID: <20020131001609.GA31911@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.2 (i686)
X-uptime: 4:07pm  up 11 days, 11:01,  2 users,  load average: 0.12, 0.09, 0.12
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Just an FYI.. when one runs 'make xconfig', and goes to request help 
on a certain option given, a message comes up:

                                RTFM

No Help available - unable to open file Documentation/Configure.help. This 
file should have come with your kernel.

        Vanilla 2.5.3 and the patch for it, removes the file. Is this being 
worked on? make oldconfig will work for now, but just a heads up.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

