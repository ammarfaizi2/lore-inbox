Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbRFFHH1>; Wed, 6 Jun 2001 03:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRFFHHR>; Wed, 6 Jun 2001 03:07:17 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:2295 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263060AbRFFHHD>; Wed, 6 Jun 2001 03:07:03 -0400
Message-ID: <3B1DD68A.17C8FD52@TeraPort.de>
Date: Wed, 06 Jun 2001 09:06:50 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 VM
In-Reply-To: <E157KV1-00077L-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------D2D1E0DB5F820C9EBBE5C428"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D2D1E0DB5F820C9EBBE5C428
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> >  Just let me add my observation. The VM behaviour of 2.4.5 (started with
> > some 2.4.4-ac kernel) is definitely less than an improvement for *my*
> 
> 2.4.5 and 2.4.4-ac are unrelated VM setups. 2.4.5-ac is probably much better
> for a lot of loads as it has the 2.4.5 general behaviour but gets the aging
> a lot more sane

 OK. Maybe my wording was implying a nonexisting relation. In any case,
the behaviour I described started with some of the later (-ac12)
versions of 2.4.4-ac and continues with 2.4.5-ac.

 On a side question: does Linux support swap-files in addition to
sawp-partitions? Even if that has a performance penalty, when the system
is swapping performance is dead anyway.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------D2D1E0DB5F820C9EBBE5C428
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
org:TeraPort GmbH;C+ITS
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;-7008
fn:Martin Knoblauch
end:vcard

--------------D2D1E0DB5F820C9EBBE5C428--

