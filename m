Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314957AbSD2JGq>; Mon, 29 Apr 2002 05:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314958AbSD2JGp>; Mon, 29 Apr 2002 05:06:45 -0400
Received: from viruswall2.epcnet.de ([62.132.156.25]:64518 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S314957AbSD2JGo>; Mon, 29 Apr 2002 05:06:44 -0400
Date: Mon, 29 Apr 2002 11:06:35 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <28447419.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020428.204911.63038910.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.8
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 29.04.2002 06:00
>
> Will you at least listen to what my proposed solution is?
> It has precisely the same effect your proposal has.
> Let me say it for millionth time:
> Networking sets "can't VLAN" by default in device flags,
> if device driver clear it we can do VLAN.  So by default
> device is marked as not VLAN capable.
> This is exactly the behavior you are asking for.  There
> is no fundamental difference between your scheme and mine
> except that I am being required to retype a description
> of mine a million times.

Sorry, i didn't got it. Now its clear. I missed that the device
flags are set in the networking code too and not only 
in the driver. I apologize me for the former posts.

Greetings

   Jochen Dolze

