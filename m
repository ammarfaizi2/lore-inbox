Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbRDWTRU>; Mon, 23 Apr 2001 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135516AbRDWTRK>; Mon, 23 Apr 2001 15:17:10 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:35081 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S135513AbRDWTRD>; Mon, 23 Apr 2001 15:17:03 -0400
Message-ID: <3AE47F9E.D8CF4B1B@netpathway.com>
Date: Mon, 23 Apr 2001 14:16:46 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: KDE Lockups with emu10k1 driver in kernel > 2.4.3-ac9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since ac9 I started having a lockup when initializing KDE 2.1.1.
Did not think that much about it since my installation has had libs
upgraded and patched for months. Today I decided to do a clean
distribution install and after I had the same problem. Removing
each module one at a time I finally narrowed in down to the
Sound Blaster Live module. Every version including ac9 and
before works fine. Has anybody else had this problem?

--
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


