Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRFDW2v>; Mon, 4 Jun 2001 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbRFDW2m>; Mon, 4 Jun 2001 18:28:42 -0400
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:3735 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262116AbRFDW2g>; Mon, 4 Jun 2001 18:28:36 -0400
Date: Mon, 4 Jun 2001 18:28:34 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2 <-> 2.4.5-ac5 tcp too slow
Message-ID: <20010604182834.A2486@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i seem to remember this being mentioned before, but couldn't find any
reference in the list archives. i have an x86 laptop running 2.2.17 (2.2.19
has the same effect) and an alpha pws 500 running 2.4.5-ac5. tcp starts slow
and get slower. it's not a 10/100 or duplex issue. icmp goes at full speed.
it doesn't matter which side starts the connection. has anyone else
experienced this? any suggestions?

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
