Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRK0O5F>; Tue, 27 Nov 2001 09:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280016AbRK0O4s>; Tue, 27 Nov 2001 09:56:48 -0500
Received: from sulu.sohanet.de ([212.42.250.66]:54278 "EHLO sulu.sohanet.de")
	by vger.kernel.org with ESMTP id <S280002AbRK0O4g>;
	Tue, 27 Nov 2001 09:56:36 -0500
Message-ID: <3C03A9AD.4040809@sohanet.de>
Date: Tue, 27 Nov 2001 15:56:45 +0100
From: Bernd Bartmann <Bernd.Bartmann@sohanet.de>
Organization: SoHaNet Technology GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <XFMail.20011127152007.ast@domdv.de> <1576.10.119.8.1.1006871893.squirrel@extranet.jtrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin A. Brooks wrote:

>>As far as I remember this was talked about earlier. Different mobos,
>>chipsets, processor brands, but always IRQ 7. /me wonders.
>>
> 
> In my research before posting, a common thread seemed to be the presence of
> a tulip card in the machine.  Has anyone seen this on a non-tulip box?


I don't have any tulip card in my system but also got this message twice

last week during backup to my Onstream DI-30 FAST ide tape streamer. 
Please have a look at my bug report to RedHat Bugzilla:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=56630

-- 
Dipl.-Ing. (FH) Bernd Bartmann <Bernd.Bartmann@sohanet.de>
SoHaNet Technology GmbH / Kaiserin-Augusta-Allee 10-11 / 10553 Berlin
Software / Hardware / Netzwerke * Entwicklung / Verkauf / Wartung
Fon: +49 30 214783-44 / Fax: +49 30 214783-46

