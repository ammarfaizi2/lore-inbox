Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292997AbSBVVNN>; Fri, 22 Feb 2002 16:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292999AbSBVVNE>; Fri, 22 Feb 2002 16:13:04 -0500
Received: from [208.190.191.184] ([208.190.191.184]:3415 "EHLO
	sekhmet.ad.newisys.com") by vger.kernel.org with ESMTP
	id <S292997AbSBVVMu> convert rfc822-to-8bit; Fri, 22 Feb 2002 16:12:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 2.4.17 system freeze
Date: Fri, 22 Feb 2002 15:13:24 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F33F912@sekhmet.ad.newisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.17 system freeze
Thread-Index: AcG75cOLh/HEbIWAQZ+72AqVkAMnPw==
From: "Dave Raddatz" <dave.raddatz@newisys.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing a problem on my dual processor athlon after moving up to 2.4.17.  I've compiled the kernel for the athlon processor, for 4GB memory support (I have 1.2 GB RAM right now) and TUX in the kernel.  My graphics is ATI Rage XL (not Nvidia - thought I saw some problems mentioned in the newsgroups discussing athlon and nvidia coexistence issues).

When I was on 2.4.2 (Red Hat 7.1), the problem did not occur.

My test case is SPECweb99 with 570 connections over two 100 Mb ethernet connections.

What happens is the system will just freeze and be non-responsive (keyboard, mouse, nothing works except to reset the box).

One thing I noticed after going from 2.4.2 up to 2.4.17 is that swpd space utilization is higher and free space was higher.  Don't know if this is related to the problem - just something that I happened to notice.

Any ideas as to what the problem might be?
Dave

-----------------------------------------------------
Dave Raddatz, Performance Analyst
Newisys, Inc.
10814 Jollyville Road
Bldg. 4, Suite 300
Austin, TX 78759
(512) 340-9050, ext. 485

