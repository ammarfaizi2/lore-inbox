Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRFNQ1c>; Thu, 14 Jun 2001 12:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFNQ1W>; Thu, 14 Jun 2001 12:27:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22416 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263340AbRFNQ1U>;
	Thu, 14 Jun 2001 12:27:20 -0400
Message-ID: <3B28E5E4.FCD7C87A@mandrakesoft.com>
Date: Thu, 14 Jun 2001 12:27:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ssh@megaepic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 kernel crash while using tcpdump+iptraf
In-Reply-To: <20010614122047.B5279@megaepic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ssh@megaepic.com wrote:
> Firstly, I apologize for the lack of detail that this report contains,
> but I have not been able to gather any detail so far. The crash seems
> to occur when I'm using tcpdump and iptraf at the same time, but not
> as soon as I run them - it takes a good couple of hours it seems. The

> I have a PII 300 running at about 40 degrees C, 64 MB RAM, /dev/hda is
> Model=WDC WD64AA, FwRev=82.10A82, SerialNo=WD-WM6531633075 running at
> udma2, matrox millenium PCI for graphics card. The kernel was compiled
> with gcc version 2.95.4 20010319 (Debian prerelease) and binutils 2.11.90.0.7
> with make-kpkg.

What kind of network card, and what network driver?

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
