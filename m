Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGJOYT>; Wed, 10 Jul 2002 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSGJOYS>; Wed, 10 Jul 2002 10:24:18 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:11187 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S315762AbSGJOYR>; Wed, 10 Jul 2002 10:24:17 -0400
Subject: Re: reiserfsprogs release
From: Steven Cole <elenstev@mesatop.com>
To: Vitaly Fertman <vitaly@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200207101206.48370.vitaly@namesys.com>
References: <200206251829.25799.vitaly@namesys.com>
	<20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> 
	<200207101206.48370.vitaly@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Jul 2002 08:23:54 -0600
Message-Id: <1026311034.7074.76.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 02:06, Vitaly Fertman wrote:
> 
> Hi all,
> 
> the latest reiserfsprogs-3.6.2 is available on our ftp site.
> 

Is the following patch to Documentation/Changes appropriate?

Steven

--- linux-2.4.19-rc1/Documentation/Changes.orig	Wed Jul 10 08:12:24 2002
+++ linux-2.4.19-rc1/Documentation/Changes	Wed Jul 10 08:13:05 2002
@@ -55,7 +55,7 @@
 o  modutils               2.4.2                   # insmod -V
 o  e2fsprogs              1.25                    # tune2fs
 o  jfsutils               1.0.12                  # fsck.jfs -V
-o  reiserfsprogs          3.x.1b                  # reiserfsck 2>&1|grep reiserfsprogs
+o  reiserfsprogs          3.6.2                   # reiserfsck 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
@@ -326,7 +326,7 @@
 
 Reiserfsprogs
 -------------
-o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.1b.tar.gz>
+o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.6.2.tar.gz>
 
 LVM toolset
 -----------

