Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266326AbRGJOCa>; Tue, 10 Jul 2001 10:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266366AbRGJOCV>; Tue, 10 Jul 2001 10:02:21 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:41919 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266326AbRGJOCD>; Tue, 10 Jul 2001 10:02:03 -0400
Message-ID: <3B4B0AEB.88038B4C@kernelconcepts.de>
Date: Tue, 10 Jul 2001 16:02:19 +0200
From: Nils Faerber <nils@kernelconcepts.de>
Organization: kernel concepts
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compressed loop for 2.4?
Content-Type: multipart/mixed;
 boundary="------------72D8C0467FE77586AF6273EA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------72D8C0467FE77586AF6273EA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all!
After some time browsing the net I cannot find any still existing
references to a latest version of the compressed loopback device driver
that Rusty Russel once did. And since most of Rusty's addresses do not
seem valid anymore I would like to ask here if someone knows something
about the actual status of compressed loopback drivers for 2.4 kernels
(or at least a pointer to older versions).
Or is someone else working on something like this?

The background is that we need a compressed rw filesystem for 2.4
kernels. Jffs2 would be nice but we currently use IDE-flash disks for
this project and cannot change :(

Any hints and/or pointers are welcome!
Thanks in advance
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
--------------72D8C0467FE77586AF6273EA
Content-Type: text/x-vcard; charset=us-ascii;
 name="nils.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nils Faerber
Content-Disposition: attachment;
 filename="nils.vcf"

begin:vcard 
n:Faerber;Nils
tel;cell:+49-170-2729106
tel;fax:+49-271-771091-19
tel;work:+49-271-771091-12
x-mozilla-html:FALSE
url:http://www.kernelconcepts.de
org:kernel concepts
adr:;;Dreisbachstrasse 24;Netphen;;57250;Germany
version:2.1
email;internet:nils@kernelconcepts.de
x-mozilla-cpt:;0
fn:Nils Faerber
end:vcard

--------------72D8C0467FE77586AF6273EA--

