Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRDOHSH>; Sun, 15 Apr 2001 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132586AbRDOHR5>; Sun, 15 Apr 2001 03:17:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47054 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132585AbRDOHRv>;
	Sun, 15 Apr 2001 03:17:51 -0400
Message-ID: <3AD94B19.C73357A1@mandrakesoft.com>
Date: Sun, 15 Apr 2001 03:17:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew W. Lowe" <swds.mlowe@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 - Module problems?
In-Reply-To: <3ADA49F0.A412EAA@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matthew W. Lowe" wrote:
> I just tried to upgrade from whatever kernel comes with redhat to 2.4.3.
> The build, install and such was smooth. When I got to starting up,
> everything appeared to work, until it got to my NIC cards. Neither of
> them loaded properly. I've built in the EXACT same module for the NICs
> as I did the previous kernel. They were the NE2000 PCI module and the
> 3C59X module. The two NICs I have are: Realtek 8029 PCI, 3COM Etherlink
> III ISA. Both are PNP, the etherlink is NOT the one with the b extention
> at the end.

Maybe this is a typo or maybe not -- "3c509" is for Etherlink III ISA,
"3c59x" is for recent 3com PCI/EISA busmastering 10/100 NICs.

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
