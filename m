Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKMPW1>; Mon, 13 Nov 2000 10:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKMPWS>; Mon, 13 Nov 2000 10:22:18 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:45065 "HELO
	atlantis.hlfl.org") by vger.kernel.org with SMTP id <S129044AbQKMPWH>;
	Mon, 13 Nov 2000 10:22:07 -0500
Date: Mon, 13 Nov 2000 16:22:05 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: David Won <phlegm@home.com>
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Newby help. Tons and tons of Oops
Message-ID: <20001113162205.A30602@profile4u.com>
Mail-Followup-To: David Won <phlegm@home.com>,
	Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <00111214191100.01043@phlegmish.com> <20001112171230.B32489@xi.linuxpower.cx> <00111307592400.01166@phlegmish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111307592400.01166@phlegmish.com>; from phlegm@home.com on Mon, Nov 13, 2000 at 07:59:24AM -0500
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Nov 13, 2000 at 07:59:24AM -0500, David Won a écrit:
> I'm running 2.4.0test11pre3. but the kernel shipped with Redhat 7 doesn't 
> work either. When I was running 2.2.15 and RedHat 6.2 before upgrading it 
> worked great. Never had an oops ever.
> I ran a memory checker under dos as well and it didn't find anything. Any 
> tips?

Could you please check:
1/ if memtest really worked, as I had problems with 2.4 (in fact, it wasn't
launched, I had to downgrade to 2.3 for having a test) (have you seen a
scrolling bar of '#' ?) (anyway, i'm sending 2.3 binary privatly)
2/ your hardware internal temperature (put your hand into the box)
3/ if every cable is correctly plugged in

It looks to me like an hardware failure, not a software one.

	Arnaud.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
