Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbRE2N6P>; Tue, 29 May 2001 09:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRE2N6F>; Tue, 29 May 2001 09:58:05 -0400
Received: from [195.122.142.9] ([195.122.142.9]:10381 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S262176AbRE2N54>; Tue, 29 May 2001 09:57:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: VIA KT133A Northbridge bug reported
Date: Tue, 29 May 2001 15:56:15 +0200
Organization: Internet Factory AG
Message-ID: <3B13AA7F.F9C0454@internet-factory.de>
In-Reply-To: <Pine.SOL.3.96.1010528204546.23787A-100000@virgo.cus.cam.ac.uk>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Trace: darkstar.internet-factory.de 991144575 30971 195.122.142.158 (29 May 2001 13:56:15 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 29 May 2001 13:56:15 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac2 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr S.M. Huen" proclaimed:

> I saw a report on AMDZone of another VIA chipset bug.  The original source
> is:-
> http://www.chip.de/news_stories/news_stories_163106.html
> 
> The claim from AMDZone's translation is that:-
> " According to the report KT133A boards with chipset codes of 1EA0 and
> 1EA4 can have the bug which causes your computer to restart."

This seems like a translation error. The german original reads
"Eigentlich für C-Athlons ausgelegt, produziert die Northbridge VT8363A
Restart-Probleme mit genau dieser CPU." which roughly translates to
"Originally intended for C-Athlons, the Northbridge VT8363A causes
restart problems with exactly this CPU."

The original article goes on with "Wie Stephan Schwolow von MSI
Deutschland gegenüber CHIP Online mitteilte, lässt sich das Problem mit
der VIA-Northbridge anhand eines Warmstarts aus dem DOS-Modus oder einem
Windows-Neustart identifizieren: Bleibt der Bildschirm schwarz, hat der
Chip einen Fehler."

Translation: "As Stephan Schwolow from MSI Germany told Chip Online, the
problem with the VIA northbridge can be identified by a warm start from
DOS or a Windows reboot: If the screen stays black, the chip has an
error."

As far as I understand it, the problem is only affecting "warm reboots".
And I couldn't care less about warm reboots - my machines usually run
24/7 :) 

Holger
