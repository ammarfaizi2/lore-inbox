Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272220AbRIKAOJ>; Mon, 10 Sep 2001 20:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRIKAN7>; Mon, 10 Sep 2001 20:13:59 -0400
Received: from 212-170-187-103.uc.nombres.ttd.es ([212.170.187.103]:33540 "EHLO
	femto") by vger.kernel.org with ESMTP id <S272209AbRIKANw>;
	Mon, 10 Sep 2001 20:13:52 -0400
Date: Tue, 11 Sep 2001 02:13:42 +0200
From: Eric Van Buggenhaut <ericvb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PCMCIA_APA1480 not linked to any code ?
Message-ID: <20010911021342.A2682@eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Echelon: FBI CIA NSA Handgun Assault Atomic Bomb Heroin Drug Terrorism
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm with 2.4.9 source tree.

Documentation/Configure.help documents a CONFIG_PCMCIA_APA1480 but this option
doesn't lead to any code ?!

femto:/usr/src/linux-2.4.9[0]# grep -r CONFIG_PCMCIA_APA1480 *
Documentation/Configure.help:CONFIG_PCMCIA_APA1480
femto:/usr/src/linux-2.4.9[0]#

Am I missing something ?

Thanks.

Please CC me any answer/comment.

-- 
Eric VAN BUGGENHAUT

Eric.VanBuggenhaut@AdValvas.be
