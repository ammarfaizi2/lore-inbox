Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137131AbREKNOr>; Fri, 11 May 2001 09:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137132AbREKNOh>; Fri, 11 May 2001 09:14:37 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:4812 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S137131AbREKNOT>; Fri, 11 May 2001 09:14:19 -0400
Message-ID: <3AFBE5BF.5865B0CA@TeraPort.de>
Date: Fri, 11 May 2001 15:14:39 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Size of /proc/kcore growing over time ?
Content-Type: multipart/mixed;
 boundary="------------07D11B886CDB1F3C5EFF9CB2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------07D11B886CDB1F3C5EFF9CB2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

 is it normal that the size of /proc/kcore grows over time? Directly
after a boot it has the size of the physical memory. Over time it seems
to grow slightly. In about a day it went from 192 MB to about 203 MB.
This is 2.4.4-ac6 running on a Toshiba Notebook.

 I ask, because I thought the size of kproc could be used to determine
the amount of physical memory. If this assumption is wrong, is there
another way to achive the goal?

Happy weekend
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------07D11B886CDB1F3C5EFF9CB2
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

--------------07D11B886CDB1F3C5EFF9CB2--

