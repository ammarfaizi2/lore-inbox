Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRBMAUh>; Mon, 12 Feb 2001 19:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130122AbRBMAU1>; Mon, 12 Feb 2001 19:20:27 -0500
Received: from panther.wmin.ac.uk ([161.74.55.127]:11165 "EHLO
	panther.wmin.ac.uk") by vger.kernel.org with ESMTP
	id <S130119AbRBMAUJ>; Mon, 12 Feb 2001 19:20:09 -0500
To: linux-kernel@vger.kernel.org
Subject: pcmcia-issues with 2.2.18 & 2.4.0
From: Stig Brautaset <stigbrau@online.no>
Date: 13 Feb 2001 00:19:25 +0000
Message-ID: <87k86vzb76.fsf@arwen.wmin.ac.uk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am no kernel hacker, but I would like to file a bug-report none the
less. Please CC me with follow-ups (if any ;-) since I am not
subscribing to the mailing list.

I have a Xircom Combo CardBus (32 bit) 10/100 Ethernet Card + 56k
Modem (didn't try the modem part) that I have not been able to run
under 2.2.18 or 2.4.0. The weird part is that everything seems to load
fine, and I am able to configure the card with an ip-address and
everything. Only sad part is that I can not reach out to the world. I
just get connection time-outs when trying to acces the 'net.

The card runs fine under 2.2.17, but not with pcmcia-cs package
version later than 3.1.20 (I do realize that this probably have little
to do with the kernel).

BTW, The driver used by the card is tulip_cb, and the machine it runs
on is a Dell Latitude CPx H500GT.

Regards, Stig
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
