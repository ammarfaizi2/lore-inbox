Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRD2Ppp>; Sun, 29 Apr 2001 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135821AbRD2Ppf>; Sun, 29 Apr 2001 11:45:35 -0400
Received: from d141-223-202.home.cgocable.net ([24.141.223.202]:13754 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S135820AbRD2PpY>; Sun, 29 Apr 2001 11:45:24 -0400
Date: Sun, 29 Apr 2001 11:46:35 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>,
        David Lang <david.lang@digitalinsight.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
In-Reply-To: <20010429130432.I679@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.30.0104291145160.1938-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm plugged in to a cable modem, with the DHCP server at the ISP.  The
> server requires the MAC address to be registered, so sending the DHCP
> request with a different MAC address could cause the symptoms.  I doubt
> it's a timing problem - replacing the 8139 driver with the 2.4.3 version
> but otherwise using the distributed 2.4.4 makes DHCP work as expected.

I meant to get back sooner. I'm also plugged into a cable modem (though
trhough a 5 port hub). Same symptoms for me.

-- 
Garett

