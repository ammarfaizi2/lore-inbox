Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292400AbSB0MbH>; Wed, 27 Feb 2002 07:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSB0Ma6>; Wed, 27 Feb 2002 07:30:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292397AbSB0Mas> convert rfc822-to-8bit;
	Wed, 27 Feb 2002 07:30:48 -0500
Date: Wed, 27 Feb 2002 04:28:45 -0800 (PST)
Message-Id: <20020227.042845.54186884.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020227132454.B24996@stud.ntnu.no>
In-Reply-To: <20020227125611.A20415@stud.ntnu.no>
	<20020227.040653.58455636.davem@redhat.com>
	<20020227132454.B24996@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Wed, 27 Feb 2002 13:24:54 +0100
   
   Do you want a dump of the vpd_data it receives?

It isn't interesting, so no.

   Here's the dmesg line after
   the driver is loaded:
   
Thank you.

   The machine is a Dell PowerEdge 2550 machine, running RedHat Linux 7.2 (with
   2.4.18 kernel).  Let me know if you want me to run any specific tests, it's
   connected to a Cisco switch with gigabit-ports (so I can actually test
   things like jumboframes if needed).

At this point I'm mostly interested in if it works at all :-)

If the answer is yes, tell me that and then you can feel
free to experiment with jumbo frames et al. to discover
other bugs in the driver :-)
