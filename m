Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136766AbRECLbS>; Thu, 3 May 2001 07:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136771AbRECLbJ>; Thu, 3 May 2001 07:31:09 -0400
Received: from tpau.muc.eurocyber.net ([195.143.108.12]:8965 "EHLO
	tpau.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S136766AbRECLa6>; Thu, 3 May 2001 07:30:58 -0400
Message-ID: <3AF14177.B3579918@TeraPort.de>
Date: Thu, 03 May 2001 13:31:03 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4
In-Reply-To: <E14vFZb-0005GA-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------EBF745D0072568C301F25F2E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EBF745D0072568C301F25F2E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> >  my DE-620 pccard stopped working after upgrading the kernel from
> > 2.4.3-ac7 to 2.4.4. This is on a Toshiba 4080XCDT. I used the "good"
> > .config from the 2.4.3-ac7 build to do a make "oldconfig". The symptoms
> > at startup are:
> 
> 2.4.4 has older pcmcia than 2.4.3-ac7. It might be that. Does 2.4.4-ac work ?
Alan,

 thanks for replying. Which 2.4.4-ac would you recommend? BUT, I
actually think that the pcmcia stuff broke already in the 2.4.3-ac
series at 9 or 10. At that point, I was to busy reporting it :-( Doing
new kernels on my notebook is kind of low priority... I had the
impression that either the rwsem or the pnpbios stuff was involved. As I
said, I did not follow up at that time.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------EBF745D0072568C301F25F2E
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

--------------EBF745D0072568C301F25F2E--

