Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272562AbRIFUfr>; Thu, 6 Sep 2001 16:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272565AbRIFUfh>; Thu, 6 Sep 2001 16:35:37 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1037 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272562AbRIFUfT>; Thu, 6 Sep 2001 16:35:19 -0400
Date: Thu, 6 Sep 2001 22:13:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wietse Venema <wietse@porcupine.org>, kuznet@ms2.inr.ac.ru,
        Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906221359.G13547@emma1.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wietse Venema <wietse@porcupine.org>, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <20010906181826.9CCECBC06C@spike.porcupine.org> <E15f55T-0000Kc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15f55T-0000Kc-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, Alan Cox wrote:

> I think you have the metaphor wrong. The older API is a bit like the 
> cavalry charging into battle at the start of world war one. It may have been
> how everyone did it but they guys with the "newfangled, really not how it
> should be done, definitely not cricket"  machine guns got the last laugh

Alan, portability is an issue or Linux will lose. Admittedly, legacy
interfaces do not support all of those new features, but a rather
trivial patch of mine brings SIOCGIFNETMASK compatibility with both the
old and the new stuff, please name precisely the objections against
portability and compatibility with FreeBSD 4.x aliasing.

-- 
Matthias Andree
Outlook (Express) users: press Ctrl+F3 for the full source code of this post.
begin  dont_click_this_virus.exe
end
