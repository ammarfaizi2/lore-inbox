Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbRBPN7w>; Fri, 16 Feb 2001 08:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBPN7m>; Fri, 16 Feb 2001 08:59:42 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:49932 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129426AbRBPN7j>; Fri, 16 Feb 2001 08:59:39 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: <linux-kernel@vger.kernel.org>
Subject: quotaon -guav on 2.4.1-ac15
Date: Fri, 16 Feb 2001 05:59:22 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHAEPCEMAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't recall seeing this problem in 2.4.0...

quotaon: using /home/vhosts/b/quota.user on /dev/sda3: Invalid argument
quotaon: using /home/vhosts/a/quota.user on /dev/sdb1: Invalid argument

Here's my ver_linux:

Linux omega 2.4.1-ac15 #1 SMP Thu Feb 15 21:33:19 PST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10f
modutils               2.4.1
e2fsprogs              1.19
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0

I'm using quota-2.00.  Any ideas?  Is this a bad message?

Thanks,
--
Vibol Hou
KhmerConnection, http://khmer.cc
"Connecting Cambodian Minds, Art, and Culture"
