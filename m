Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRF0QSN>; Wed, 27 Jun 2001 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263862AbRF0QSD>; Wed, 27 Jun 2001 12:18:03 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:53483 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263766AbRF0QRq>; Wed, 27 Jun 2001 12:17:46 -0400
Message-ID: <3B3A06CD.97E9ACDB@TeraPort.de>
Date: Wed, 27 Jun 2001 18:16:13 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ReiserFS patches vs. 2.4.5-ac series
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 what is the current relation between the reiserfs patches at
namesys.com and the 2.4.5-ac series kernel?

 Namesys seems to have a small one for the "umount" problem and two 
bigger ones (knfsd and knfsd+quota+mount). All apply cleanly to vanilla
2.4.5, but the bigger ones fails against ac18 and ac19 (earlier ones
also I would guess). Are some of the knfsd/quota fixes already in -ac?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
