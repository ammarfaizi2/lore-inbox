Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSDXRm3>; Wed, 24 Apr 2002 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDXRm2>; Wed, 24 Apr 2002 13:42:28 -0400
Received: from proxyserver.epcnet.de ([62.132.156.25]:55310 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312444AbSDXRm1>; Wed, 24 Apr 2002 13:42:27 -0400
Date: Wed, 24 Apr 2002 19:42:24 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <210844917.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020424.095951.43413800.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 24.04.2002 19:10
> Yes, the "cannot do VLAN" flag is there in 2.4.x

Mhh, did not found the symbol in netdevice.h on stock 2.4.18.

> VLAN layer checks this and fails to bring up VLAN if
> flag is set for the device being configured.  I'm way
> ahead of you.

Ok, awaiting your changes.

Greetings

   Jochen Dolze

