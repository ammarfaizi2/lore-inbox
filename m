Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRFQTKr>; Sun, 17 Jun 2001 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFQTKj>; Sun, 17 Jun 2001 15:10:39 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:9220
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S262616AbRFQTKZ>; Sun, 17 Jun 2001 15:10:25 -0400
Date: Sun, 17 Jun 2001 16:09:57 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: <eepro100@scyld.com>, <saw@saw.sw.com.sg>, <linux-kernel@vger.kernel.org>,
        Jeff Chua <jchua@fedex.com>
Subject: Re: eepro100 problems with 2.2.19 _and_ 2.4.0
In-Reply-To: <003e01c0f745$3e0cbc40$a35812bc@corp.fedex.com>
Message-ID: <Pine.LNX.4.32.0106171608580.140-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Jeff Chua wrote:

> Try to add "options eepro100 options=0" to your /etc/modules.conf
> to default the speed to 10Mbps if you're using 10BaseT.

I'm not using modules for this driver (can't see the point, really); does
this fix anything if I change it to 0x20 for 100BaseT?

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

