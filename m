Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292627AbSBVQgF>; Fri, 22 Feb 2002 11:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292655AbSBVQf4>; Fri, 22 Feb 2002 11:35:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292627AbSBVQfi>;
	Fri, 22 Feb 2002 11:35:38 -0500
Message-ID: <3C767359.44CD415E@mandrakesoft.com>
Date: Fri, 22 Feb 2002 11:35:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sunsite.dk>
CC: Ben Greear <greearb@candelatech.com>, Petro <petro@auctionwatch.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <20020213211639.GB2742@auctionwatch.com> <3C6B2277.CA9A0BF8@mandrakesoft.com> <3C6B406E.1010706@candelatech.com> <3C6B4B20.FE4AE960@mandrakesoft.com> <d3sn7ttrcb.fsf@lxplus050.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Would be a lot nicer to see someone spending the time pulling the
> useful bits out of e100 and putting it into eepro100. e100 is ugly and
> bloated for no reason.

When it passes my review, it will not be.

e100 + my desired changes == eepro100 + my desired changes

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
