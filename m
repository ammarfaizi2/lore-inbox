Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319182AbSH2LID>; Thu, 29 Aug 2002 07:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319185AbSH2LIC>; Thu, 29 Aug 2002 07:08:02 -0400
Received: from [62.70.77.106] ([62.70.77.106]:63398 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S319182AbSH2LIC> convert rfc822-to-8bit;
	Thu, 29 Aug 2002 07:08:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
Subject: 2.4.20-pre5 more stable than 2.4.19??? (was e1000/2.4)
Date: Thu, 29 Aug 2002 13:14:11 +0200
User-Agent: KMail/1.4.1
To: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208291314.11638.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

David S. Miller tells me here that '2.4.20-pre5 is tons more stable than 
2.4.19 anyways'

is this correct?

----------  Forwarded Message  ----------

Subject: e1000/2.4
Date: Thu, 29 Aug 2002 03:42:55 -0700 (PDT)
From: "David S. Miller" <davem@redhat.com>
To: roy@karlsbakk.net

If you get "a patch" it almost certainly won't build because the e1000
driver in 2.4.20-preX depends upon the NAPI stuff we added to the
2.4.x tree

2.4.20-pre5 is tons more stable than 2.4.19 anyways :-)

-------------------------------------------------------

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

