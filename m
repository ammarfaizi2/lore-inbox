Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbRE0MOB>; Sun, 27 May 2001 08:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbRE0MNv>; Sun, 27 May 2001 08:13:51 -0400
Received: from ns2.radioschefer.ch ([62.2.224.35]:58118 "EHLO
	ns2.radioschefer.ch") by vger.kernel.org with ESMTP
	id <S261913AbRE0MNl>; Sun, 27 May 2001 08:13:41 -0400
Message-ID: <3B10ECF2.220E1DFB@bluewin.ch>
Date: Sun, 27 May 2001 14:02:58 +0200
From: Stephan Brauss <sbrauss@bluewin.ch>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD DT  (Win95; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any other hints are welcome (other than the noapic, which didn't help).
My system is always completely dead as soon as I start a larger (interrupt
driven?) data transfer to/from any (? I tested with two different NICs and a Promise
Ultra100) PCI card in slot 4 or 5. And it seems that it really only occurs 
in slots 4 and 5... To get rid of it, I switched to 2.2.19.
