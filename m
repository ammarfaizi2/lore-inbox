Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbREWHKk>; Wed, 23 May 2001 03:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbREWHK3>; Wed, 23 May 2001 03:10:29 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:53738 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262504AbREWHKQ>; Wed, 23 May 2001 03:10:16 -0400
Message-ID: <3B0B624B.A5255720@TeraPort.de>
Date: Wed, 23 May 2001 09:10:03 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <Pine.LNX.4.30.0105230345440.22207-100000@Appserv.suse.de>
Content-Type: multipart/mixed;
 boundary="------------06B3DFAD9721D4C56CAC820D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------06B3DFAD9721D4C56CAC820D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> 
> On Wed, 23 May 2001, Martin Knoblauch wrote:
> 
> >  They may not be stupid, just mislead :-( When Intel created the "cpuid"
> > Feature some way along the P3 line, they gave a stupid reason for it and
> > created a big public uproar. As silly as I think that was (on both
> > sides), the term "cpuid" is tainted. Some people just fear it like hell.
> > Anyway.
> 
> I think you are confusing the CPU serial number with CPUID which is
> not the same. CPUID instruction has been around since late 486en.
> 

 seems I am being confused. If that happens to me :-) ....

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------06B3DFAD9721D4C56CAC820D
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

--------------06B3DFAD9721D4C56CAC820D--

