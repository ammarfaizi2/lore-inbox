Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269353AbRHCIpo>; Fri, 3 Aug 2001 04:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHCIpf>; Fri, 3 Aug 2001 04:45:35 -0400
Received: from elin.scali.no ([195.139.250.10]:32264 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269353AbRHCIpY>;
	Fri, 3 Aug 2001 04:45:24 -0400
Message-ID: <3B6A65BF.2DFDEA6C@scali.no>
Date: Fri, 03 Aug 2001 10:50:07 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <20010803000043.F1183@higherplane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:
> 
> On Thu, Aug 02, 2001 at 01:30:53PM +0100, Alan Cox wrote:
> > I think just disable SMP in that case. There are currently no SMP Pentium IV
> > boxes and perhaps Intel will have fixed it by the time SMP Pentium IV exists
> 
> yes there are, they may not be available to the general public yet
> however:
> 
> http://anandtech.com/cpu/showdoc.html?i=1472&p=5
> 

Hmm, we have two dual Pentium IV systems here in our lab, and they are
available to the public (atleast SuperMicro & Tyan makes them). This is however
Pentium IV Xeon chips (i.e not plain Pentium IV) and they use the Intel 860
chipset. I've not seen any problems yet with these system (using RedHat 7.1
with 2.4.3-12smp kernel).

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
