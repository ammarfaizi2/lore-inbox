Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135506AbRDSBXA>; Wed, 18 Apr 2001 21:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135505AbRDSBWv>; Wed, 18 Apr 2001 21:22:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135504AbRDSBWd>; Wed, 18 Apr 2001 21:22:33 -0400
Subject: Re: APIC errors ...
To: bruce@ask.ne.jp (Bruce Harada)
Date: Thu, 19 Apr 2001 02:22:58 +0100 (BST)
Cc: kernel@blackhole.compendium-tech.com (Dr. Kelsey Hudson), kurt@garloff.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010417211222.5de56788.bruce@ask.ne.jp> from "Bruce Harada" at Apr 17, 2001 09:12:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14q39x-00068C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Er... I believe there was some discussion on l-k some while ago regarding a
> certain lack of forthcomingness by Serverworks and the resultant general
> flakiness of Linux support for their chipsets...

Serverworks stuff is pretty well supported now - they've been working to make
some stuff available. Having said that their AGP isnt supported (and is 
reportedly pretty poor in windows) and they seem to lack UDMA100 IDE right now.

Of course server customers think IDE is an attachment for cdroms and zip drives..

