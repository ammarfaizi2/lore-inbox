Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRI0Xph>; Thu, 27 Sep 2001 19:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274137AbRI0Xp0>; Thu, 27 Sep 2001 19:45:26 -0400
Received: from cr1041142-a.mtmk1.on.wave.home.com ([24.156.58.161]:37389 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S274133AbRI0XpP>;
	Thu, 27 Sep 2001 19:45:15 -0400
Message-ID: <3BB3BA24.328D5791@datawire.net>
Date: Thu, 27 Sep 2001 19:45:41 -0400
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: Re: HPNA 2.0 Update Binary only driver released as beta
In-Reply-To: <3BB1485A.F964EF93@datawire.net>
Content-Type: multipart/mixed;
 boundary="------------6F01D237812221C518B851F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6F01D237812221C518B851F1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

the HomePNA group has given me a binary driver for HPNA 2.0 Linksys
cards.

It is beta and can be found at:

lynx ftp://ftp.linksys.com/beta/linux_full_binary_2_33.exe

you can use Wine to extract it since its a windows setup executable
(LAME!)

perhaps we can dissasemble this module and build a non cluttered
driver? :-)

>From the readme.txt:

Linux Release 2_33

Linux network device driver for the Broadcom BCM42XX PCI

InsideLine 10Mbps Home Phoneline Networking chip.

This release includes:
- support for HPNA 2.0 Certification Testing
- MODVERSIONS support for Linux 2.2 and 2.4 Kernels.  These
modules have been compiled and tested with MODVERSIONS defined
on a RedHat 6.2 system with include files from the RedHat
2.2.14-5.0 kernel.  The driver for the 2.4 kernel uses the
2.4.0-test10 kernel distribution from ftp.kernel.org.

Note:  The kernels should be compiled with nonSMP

This distribution includes two il.o executables:

  - \Kernel_2.2.14-5.0\il.o ---> 62545 bytes (nonSMP)
  - \Kernel_2.4.0-Test10\il.o ---> 70695 bytes (nonSMP)


Shawn Starr wrote:

> http://www.homepna.org/docs/paper500.pdf
>
> I found this document via google and it tells you the format for an
> HPNA 2.0 frame
>
> Shawn.

--------------6F01D237812221C518B851F1
Content-Type: text/x-vcard; charset=iso-8859-15;
 name="shawn.starr.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Shawn Starr
Content-Disposition: attachment;
 filename="shawn.starr.vcf"

begin:vcard 
n:Starr;Shawn
tel;fax:416-213-2008
tel;home:905-707-1154
tel;work:416-213-2001- ext 179
x-mozilla-html:FALSE
url:http://www.datawire.net
org:Datawire Communication Networks Inc.;Engineering
adr:;;10 Carlson Court, Suite 300;Toronto;Ontario;M9W 6L2;Canada
version:2.1
email;internet:shawn.starr@datawire.net
title:UNIX System Administrator, Operations
x-mozilla-cpt:;0
fn:Shawn Starr
end:vcard

--------------6F01D237812221C518B851F1--

