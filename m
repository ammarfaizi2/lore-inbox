Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278557AbRJSRNO>; Fri, 19 Oct 2001 13:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278556AbRJSRNG>; Fri, 19 Oct 2001 13:13:06 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:54537 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S278555AbRJSRMq>;
	Fri, 19 Oct 2001 13:12:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110191713.VAA03502@ms2.inr.ac.ru>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
To: saw@saw.sw.com.sg (Andrey Savochkin)
Date: Fri, 19 Oct 2001 21:13:12 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
In-Reply-To: <20011019173233.A12919@castle.nmd.msu.ru> from "Andrey Savochkin" at Oct 19, 1 05:32:33 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I don't want to turn on proxy arp on an interface basis, because subtle
> mistakes in network configuration with proxy arp turned on may have serious
> consequences, including arp storm (sic!),

Andrey, do not fuck me brains. :-) (translate this to English :-))
No "serious" consequences exist. And not serious ones are surely covered
by the same mistakes which you can make forced to add useless element
to configuration.

I am sorry, but each additional item to configure increases
probability of mistake by... count yourselves. :-)


> Or you just want to cripple `ip'? :-)

Rather to cure it amputating dead flesh alien for "ip".
"ip neigh add proxy" was added as a demo of "right" interface
to this feature mostly to have a reason to say several words
about sense of proxy arp in manual. As soon as people do not read docs
anyway (or I wrote some unintellibible shit there) this function
loses its sense.

Alexey
