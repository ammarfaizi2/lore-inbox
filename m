Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRGCKKd>; Tue, 3 Jul 2001 06:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbRGCKKX>; Tue, 3 Jul 2001 06:10:23 -0400
Received: from [154.32.42.9] ([154.32.42.9]:59284 "EHLO hxn.pointers.co.uk")
	by vger.kernel.org with ESMTP id <S263149AbRGCKKP>;
	Tue, 3 Jul 2001 06:10:15 -0400
Message-ID: <3B419A69.A7C08FE1@infront.co.uk>
Date: Tue, 03 Jul 2001 11:11:53 +0100
From: Scott Nursten <scottn@infront.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, 

Was there ever any resolution to this thread? I'm running a bunch of Compaq DL-360's which seem to work fine on the 2.2.19pre series. As soon as I go to 2.2.19, networking doesn't work. Machines are spec'd as follows:

2 x P3-933
1.4GB RAM
Compaq RLO card
Compaq Smart2 Array Controller
2 x EtherExpress Pro onboard
2 x EtherExpress Pro PCI (the dual port server adapter from Intel)

Caveat: whenever I run `ifconfig device down` the machine locks up completely. 

Willing to give any information necessary in exchange for working kernel :) Any takers? Tell me what you guys need. 

Rgds, 

-- 
Scott Nursten - Systems Administrator
Streets Online Ltd.

Direct:		+44 (0) 1293 744 122
Business:       +44 (0) 1293 402 040
Fax:            +44 (0) 1293 402 050
Email:          scottn@streetsonline.co.uk

      -----------------------------------------------------------------------
	"Unix is user friendly. It's just selective when choosing friends."
      -----------------------------------------------------------------------
