Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRERJhJ>; Fri, 18 May 2001 05:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbRERJg7>; Fri, 18 May 2001 05:36:59 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:49377 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262288AbRERJgs>; Fri, 18 May 2001 05:36:48 -0400
Message-ID: <3B04E9E4.16ED592B@TeraPort.de>
Date: Fri, 18 May 2001 11:22:44 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Cosmetic problem in Documentation/Changes [2.4.x]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 apparently the method to find out the version of the reiserfs[progs]
mentioned in above file does not produce any result at all.

# reiserfsck 2>&1|grep reiserfsprogs

 reports nothing. If I look at the output "manually", there does not
seem to be any version in there.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
