Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263948AbRFHKqp>; Fri, 8 Jun 2001 06:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263949AbRFHKqe>; Fri, 8 Jun 2001 06:46:34 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:44493 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263948AbRFHKqT>; Fri, 8 Jun 2001 06:46:19 -0400
Message-ID: <3B20ACF4.D72866A1@TeraPort.de>
Date: Fri, 08 Jun 2001 12:46:12 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM suggestion...
Content-Type: multipart/mixed;
 boundary="------------F6FEDAD05F0F517CFDE77C8A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F6FEDAD05F0F517CFDE77C8A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>While you guys are in there hacking, perhaps consider adding metrics 
>which allows you to tell exactly when certain cases and conditions are 
>hit. 
>        page_aged_while_sleeping_in_page_lauder++ 
>
>Statistics like this are cheap to use in runtime and should provide 
>concrete information rather than guesses and estimations... 

 after following the several [very entertaining/enlightening] threads on
VM [mis]behaviour, I wanted to ask a similar question: are there any
counters/statistics about the various buffers/caches in the VMS system,
that are easily available to userland? I know other Unix OSSes, where
you can get a lot of information about the efficiency of the subsystem.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------F6FEDAD05F0F517CFDE77C8A
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

--------------F6FEDAD05F0F517CFDE77C8A--

