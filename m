Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAZSFD>; Fri, 26 Jan 2001 13:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbRAZSEn>; Fri, 26 Jan 2001 13:04:43 -0500
Received: from palrel1.hp.com ([156.153.255.242]:18443 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129735AbRAZSEi>;
	Fri, 26 Jan 2001 13:04:38 -0500
Message-ID: <3A71BC34.F8024103@cup.hp.com>
Date: Fri, 26 Jan 2001 10:04:36 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
				<94qcvm$9qp$1@cesium.transmeta.com>
				<14960.54069.369317.517425@pizda.ninka.net>
				<3A70D524.11362EFB@transmeta.com>
				<14960.54852.630103.360704@pizda.ninka.net>
				<3A70D7B2.F8C5F67C@transmeta.com> <14960.56461.296642.488513@pizda.ninka.net> <3A70DDC4.6D1DB1EC@transmeta.com> <3A713B3F.24AC9C35@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As David pointed out, it is "reserved for future use - you must set
> these bits to zero and not use it _for your own purposes_.   For non-rfc
> use of these bits _will_ break something the day we start using them
> for something useful.
> 
> So, no reason for a firewall author to check these bits.

I thought that most firewalls were supposed to be insanely paranoid.
Perhaps it would be considered a possible covert data channel, as
farfecthed as that may sound.

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
