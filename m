Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135310AbRAQSaX>; Wed, 17 Jan 2001 13:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135417AbRAQSaO>; Wed, 17 Jan 2001 13:30:14 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:60536 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S135310AbRAQS3y>; Wed, 17 Jan 2001 13:29:54 -0500
Date: Wed, 17 Jan 2001 19:29:51 +0100
Message-Id: <200101171829.f0HITpQ03309@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100 error messages
In-Reply-To: <20010117093558.B3707@home.ds9a.nl>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.8-20010108 ("Paradise Regained") (UNIX) (Linux/2.4.0 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010117093558.B3707@home.ds9a.nl> you wrote:

> On Tue, Jan 16, 2001 at 07:02:52PM -0800, Kostas Nikoloudakis wrote:

>> The machine is running under heavy CPU + memory + network load.
>> It seems that the card has problems finding the required resources.
>> Is there a way to "guarantee" that the card will have the necessary
>> resources even at high loads?
>> 
>> I'm using kernel version 2.2.14.

> Try using 2.2.18 - lots of work has been done to get the eepro100 working
> properly.

Nope. I have got similar problem with 2.2.19pre7.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
