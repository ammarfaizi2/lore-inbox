Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317832AbSGPNlC>; Tue, 16 Jul 2002 09:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317835AbSGPNlB>; Tue, 16 Jul 2002 09:41:01 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:31670 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S317832AbSGPNlA>;
	Tue, 16 Jul 2002 09:41:00 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
References: <200207151111.22555.henrique@cyclades.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 16 Jul 2002 15:10:33 +0200
In-Reply-To: <200207151111.22555.henrique@cyclades.com>
Message-ID: <m37kjvg6nq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

henrique <henrique@cyclades.com> writes:

> I'm using the generic hdlc layer with PPP protocol against a Lucent MAX6000. 
> Everything works OK but there a kernel message bothering me:
> 
> 	protocol 0008 is buggy, dev hdlc0
> 
> I get this message nearly once per minute.
> 
> Do anyone know what is this message about ?

Not sure what exactly causes it. I was getting it while running tcpdump
on PPP device.

> Must I worry about that ? 

No.
-- 
Krzysztof Halasa
Network Administrator
