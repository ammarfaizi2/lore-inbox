Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAJUAy>; Wed, 10 Jan 2001 15:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136228AbRAJUAo>; Wed, 10 Jan 2001 15:00:44 -0500
Received: from proxy.jakinternet.co.uk ([212.187.250.66]:64018 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S129436AbRAJUAf>; Wed, 10 Jan 2001 15:00:35 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Udo A. Steinberg
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <356f.3a5cbf4d.182ad@trespassersw.daria.co.uk>
Date: Wed, 10 Jan 2001 20:00:13 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <3A5C96BB.96B19DB@hell.wh8.tu-dresden.de>,
	"Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De> writes:
UAS> 
UAS> Next backed out the entire XMM and FXSR related stuff and now everything
UAS> is fine again. The CPU in question is an AMD Thunderbird (see cpuinfo
UAS> below). A friend with a similar setup but a Pentium-3 CPU doesn't seem
UAS> to see the problem (couldn't verify myself).
UAS> 

Yes. Broke horribly on my Duron 800. Time set to Dec 22 1932, X
completely confused. Anything to do the the network very
slow. Rebooted back into 2.4.0 and normality (including correct time).

Definitly an AMD issue.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
