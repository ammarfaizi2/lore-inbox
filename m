Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135627AbRDSLhc>; Thu, 19 Apr 2001 07:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135629AbRDSLhV>; Thu, 19 Apr 2001 07:37:21 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:56032 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S135628AbRDSLhH>; Thu, 19 Apr 2001 07:37:07 -0400
Date: Thu, 19 Apr 2001 12:33:36 +0100 (BST)
From: Dave Gilbert <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: routing question: Kernel being too helpful
Message-ID: <Pine.LNX.4.10.10104191227240.2637-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm trying to set up a PC with two (gig)ether cards as a test system in
which a router/firewall/what have you/ could be inserted between the two
ether cards.  Then I want to send various lumps of test traffic between
the two.

Unfortunatly Linux is being a little too helpful - whatever the routing
tables are set as, any packets intended for one card just hops over
internally and doesn't actually go over the wire.

Two machines were originally going to be used but due to physical space
constraints that has had to be given up.

Where is the short-circuit routing done which does this? (I understand it
is good and normal behaviour - I just want to turn it off).

Thanks in advance,

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on Alpha, | Happy  \ 
\   gro.gilbert @ treblig.org | 68K,MIPS,x86,ARM and SPARC  | In Hex /
 \ ___________________________|___ http://www.treblig.org   |_______/

