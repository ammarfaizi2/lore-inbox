Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbREQOWB>; Thu, 17 May 2001 10:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbREQOVu>; Thu, 17 May 2001 10:21:50 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:40185 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S261840AbREQOVk>; Thu, 17 May 2001 10:21:40 -0400
Message-ID: <3B03DB2C.1AC5D217@TeraPort.de>
Date: Thu, 17 May 2001 16:07:40 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: make menuconfig - cosmetic question
Content-Type: multipart/mixed;
 boundary="------------C3260757F265D1690A9F786A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C3260757F265D1690A9F786A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

 this is most likely just a small issue. If I knew where to look, I
would try to fix it and submit a patch :-)

 When I diff config files pocessed by "make [old]config" and "make
menueconfig", it seems that menuconfig is not writing out some of the
"comments" that the other versions do write. This is of course nothing
serious, but it ticks me off. Any idea where to look for this glitch?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------C3260757F265D1690A9F786A
Content-Type: text/x-vcard; charset=us-ascii;
 name="Martin.Knoblauch.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Martin.Knoblauch
Content-Disposition: attachment;
 filename="Martin.Knoblauch.vcf"

begin:vcard 
n:Knoblauch;Martin
tel;cell:+49-170-4904759
tel;fax:+49-89-510857-111
tel;work:+49-89-510857-309
x-mozilla-html:FALSE
url:http://www.teraport.de
org:TeraPort GmbH;IT-Services
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;32160
fn:Martin Knoblauch
end:vcard

--------------C3260757F265D1690A9F786A--

