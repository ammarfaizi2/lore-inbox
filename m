Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbRDOHL1>; Sun, 15 Apr 2001 03:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRDOHLI>; Sun, 15 Apr 2001 03:11:08 -0400
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:38628 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132582AbRDOHK4>; Sun, 15 Apr 2001 03:10:56 -0400
Message-ID: <3ADA49F0.A412EAA@home.com>
Date: Sun, 15 Apr 2001 19:25:04 -0600
From: "Matthew W. Lowe" <swds.mlowe@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 - Module problems?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to upgrade from whatever kernel comes with redhat to 2.4.3.
The build, install and such was smooth. When I got to starting up,
everything appeared to work, until it got to my NIC cards. Neither of
them loaded properly. I've built in the EXACT same module for the NICs
as I did the previous kernel. They were the NE2000 PCI module and the
3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
III ISA. Both are PNP, the etherlink is NOT the one with the b extention
at the end.

Any help would be greatly appriciated.

Thanks,
   Matt


