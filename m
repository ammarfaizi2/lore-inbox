Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315829AbSENQqR>; Tue, 14 May 2002 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315839AbSENQqR>; Tue, 14 May 2002 12:46:17 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:37124
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S315829AbSENQqP>; Tue, 14 May 2002 12:46:15 -0400
Date: Tue, 14 May 2002 18:46:10 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No Network, 2.4.19-pre8
Message-ID: <20020514184610.A2928@bouton.inet6-interne.fr>
Mail-Followup-To: Andre LeBlanc <ap.leblanc@shaw.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000701c1fb7c$d80c3640$2000a8c0@metalbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, mai 14, 2002 at 12:23:35 -0700, Andre LeBlanc wrote:
> I've tried every fix I've found on Usenet for not having a network
> connection after recompiling your kernel but nothing has seemed to work.
> the reason i'm posting it to this list is because if I boot the old (2.2.20)
> kernel from lilo my network connection is fine, but if I boot the new one
> (2.4.19-pre8) I have no network connection at all!  dmesg shows that the
> cards are detected perfectly, the drivers are compiled into the kernel and I
> also compiled in "Socket Filter" because I was told that it might work, but
> I still can't ping my firewall.  I don't know what else to try, does anyone
> have any ideas?  BTW its debian-woody
> 

Please post at least the .config at the top of the kernel source tree you used to
compile 2.4.19-pre8 and tell us about your hardware.
Have a look at REPORTING-BUGS for further recommendations.

LB.
