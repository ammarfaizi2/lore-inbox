Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSGBLzE>; Tue, 2 Jul 2002 07:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGBLzD>; Tue, 2 Jul 2002 07:55:03 -0400
Received: from web13302.mail.yahoo.com ([216.136.175.38]:59402 "HELO
	web13302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316739AbSGBLzC>; Tue, 2 Jul 2002 07:55:02 -0400
Message-ID: <20020702115731.92367.qmail@web13302.mail.yahoo.com>
Date: Tue, 2 Jul 2002 13:57:31 +0200 (CEST)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: RE: IPv6 routing table implementation
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The underlined lines will be creating a kernel panic ALWAYS.

What makes you think so? After all, the pointer is never dereferenced.
This is quite a common C trick (similiar to the offsetof macro).

Regards
  Joerg

=====
-- 
Regards
       Joerg


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Yahoo! pr‰sentiert als offizieller Sponsor das Fuﬂball-Highlight des
Jahres: - http://www.FIFAworldcup.com
