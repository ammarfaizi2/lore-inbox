Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSGEJZw>; Fri, 5 Jul 2002 05:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSGEJZw>; Fri, 5 Jul 2002 05:25:52 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:33723 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316235AbSGEJZu> convert rfc822-to-8bit; Fri, 5 Jul 2002 05:25:50 -0400
From: Matthias Welk <welk@fokus.gmd.de>
Organization: Fraunhofer Fokus
To: linux-kernel@vger.kernel.org
Subject: problem: socket receivebuffer size
Date: Fri, 5 Jul 2002 11:28:05 +0200
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200207051128.06598.welk@fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a problem with sockets and the receive buffer size.
If the size is smaller than 831 (??) byte, I did not receive udp packets (224 
byte) any more.

Syetem:
RedHat 7.2 i386
3Com Corporation 3c905B 100BaseTX [Cyclone]
kernel 2.4.9-31

Thanks, Matthias.
-- 
---------------------------------------------------------------
From: Matthias Welk                   office:  +49-30-3463-7272
      FHG Fokus                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin		      email : welk@fokus.fhg.de
----------------------------------------------------------------

