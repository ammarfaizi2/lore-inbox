Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRBOUlE>; Thu, 15 Feb 2001 15:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129988AbRBOUkb>; Thu, 15 Feb 2001 15:40:31 -0500
Received: from palrel1.hp.com ([156.153.255.242]:53769 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129183AbRBOUkZ>;
	Thu, 15 Feb 2001 15:40:25 -0500
Message-ID: <3A8C3EB5.BAB148B0@cup.hp.com>
Date: Thu, 15 Feb 2001 12:40:21 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: roger@kea.GRace.CRi.NZ, linux-kernel@vger.kernel.org
Subject: Re: MTU and 2.4.x kernel
In-Reply-To: <200102151821.VAA19711@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Default of 536 is sadistic (and apaprently will be changed eventually
> to stop tears of poor people whose providers not only supply them
> with bogus mtu values sort of 552 or even 296, but also jailed them
> to some proxy or masquearding domain), but it is still right: IP
> with mtu lower 576 is not full functional.

I thought that the specs said that 576 was the "minimum maximum"
reassemblable IP datagram size and not a minimum MTU.

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
