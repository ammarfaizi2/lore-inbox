Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSKGQov>; Thu, 7 Nov 2002 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSKGQov>; Thu, 7 Nov 2002 11:44:51 -0500
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:33196 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261460AbSKGQoC> convert rfc822-to-8bit;
	Thu, 7 Nov 2002 11:44:02 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: !(smbfs && O_LARGEFILE)
Date: Thu, 7 Nov 2002 17:50:34 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211071750.34680.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

When will smbfs support O_LARGEFILE?
I mean - smbfs tells me this, mounted from a win2k server


[root@roy-sin k]# l /mnt/proserv/s/Media/BBC/
total 10740979412
-rwxr-xr-x    1 root     root     1155723264 Nov  7 11:39 
absolutely_fabulous_srs04_ep03.m2p*
-rwxr-xr-x    1 root     root     1962631168 Nov  7 09:14 
goodness_gracious_me.m2p*
-rwxr-xr-x    1 root     root     18446744071722010624 Nov  7 12:42 
great_natural_wonders_of_the_world.m2p*
-rwxr-xr-x    1 root     root     18446744071768948736 Nov  6 17:55 
haji_the_journey_of_a_lifetime.m2p*
-rwxr-xr-x    1 root     root     18446744071793283072 Nov  7 10:20 
jkrowling_harry_potter_and_me.m2p*
-rwxr-xr-x    1 root     root     18446744071597867008 Nov  6 15:03 
kevins_guide_2ba_teenager.m2p*
-rwxr-xr-x    1 root     root     1934972928 Nov  6 13:08 
louis_therouxs_weird_weekend.m2p*
-rwxr-xr-x    1 root     root     2002108416 Nov  6 14:04 
madam_tassauds_revealed.m2p*
-rwxr-xr-x    1 root     root     18446744071799734272 Nov  6 11:31 
the_gentlemen.m2p*
-rwxr-xr-x    1 root     root     1964437504 Nov  6 16:49 the_human_face.m2p*
-rwxr-xr-x    1 root     root     1161615360 Nov  7 11:06 the_naked_chef.m2p*
-rwxr-xr-x    1 root     root     1994706944 Nov  7 13:42 
trips_money_cant_buy_w_ewan_mcgregor.m2p*
-rwxr-xr-x    1 root     root     1336358912 Nov  6 15:47 
walking_with_beasts.m2p*

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

