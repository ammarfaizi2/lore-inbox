Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSAMPz7>; Sun, 13 Jan 2002 10:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSAMPzt>; Sun, 13 Jan 2002 10:55:49 -0500
Received: from camus.xss.co.at ([194.152.162.19]:19717 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S286322AbSAMPzo>;
	Sun, 13 Jan 2002 10:55:44 -0500
Message-ID: <3C41ADF2.53839ACC@xss.co.at>
Date: Sun, 13 Jan 2002 16:55:30 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
In-Reply-To: <E16Pmjk-0007FH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
> 
> > switch. To see if it's a hardware problem I already switched
> > back to 2.2.18 once, and the problem went away.
> > Under 2.2.20 I have to boot with "noapic" to have it running
> > smoothly.
> 
> Does 2.2.19 work ?

I was afraid you'd ask... ;-)

I skipped 2.2.19 and went from 2.2.18 straight to 2.2.20
(This is our fileserver, so it's not that easy to find a 
time slot to reboot this machine...)

But I will try it today.

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
