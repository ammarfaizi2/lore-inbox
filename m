Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289130AbSAMLqP>; Sun, 13 Jan 2002 06:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289132AbSAMLqF>; Sun, 13 Jan 2002 06:46:05 -0500
Received: from camus.xss.co.at ([194.152.162.19]:47633 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S289130AbSAMLpy>;
	Sun, 13 Jan 2002 06:45:54 -0500
Message-ID: <3C417364.5358BEDD@xss.co.at>
Date: Sun, 13 Jan 2002 12:45:40 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
In-Reply-To: <E16PZxl-0003lQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
> 
> > > 2.2 does not support VIA SMP, its probably not a good kernel to choose for
> > > the buggy VIA chipsets either.
> >
> > So ServerWorks (re: his Asus CUR-DLS) is right out as well?
> 
> Serverworks I don't know. I've got reports of serverworks SMP working perfectly
> well in the 2.2 tree so I don't know what the full story is there.

This board worked fine for several months under 2.2.18
I then upgraded to 2.2.20 yesterday and noticed this problem
for the first time (I didn't try 2.2.19 on it)

I still have the full 2.2.18 installation (I did the 2.2.20
installation on a separate SCA harddisk) so I can easily
switch. To see if it's a hardware problem I already switched
back to 2.2.18 once, and the problem went away.
Under 2.2.20 I have to boot with "noapic" to have it running
smoothly.

So if someone wants me to try or test something, just send
me a short note.

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
