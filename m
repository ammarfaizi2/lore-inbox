Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276359AbRI1Wrz>; Fri, 28 Sep 2001 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRI1Wrp>; Fri, 28 Sep 2001 18:47:45 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:53478 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S276359AbRI1Wr1>; Fri, 28 Sep 2001 18:47:27 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C2081971E3@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, padraig@antefacto.com,
        linux-kernel@vger.kernel.org
Subject: RE: CPU frequency shifting "problems"
Date: Fri, 28 Sep 2001 15:47:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Remember you get an interrupt from the transition that you 
> can steal from
> the ROM gunge, or is that another deep intel secret you can't 
> comment on 8)
> 
> Just why are intel so obsessed by secrets about something 
> every other vendor
> does anyway ? 

I agree and have said the very thing internally, but TPTB have determined
that the benefit of an open source driver is outweighed by the perceived
competitive advantage of keeping it a trade secret. :(

-- Andy
