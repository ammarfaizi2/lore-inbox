Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131252AbRABR5T>; Tue, 2 Jan 2001 12:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131259AbRABR5A>; Tue, 2 Jan 2001 12:57:00 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:31872 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131258AbRABR4p>; Tue, 2 Jan 2001 12:56:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010102125545.A8981@ping.be> 
In-Reply-To: <20010102125545.A8981@ping.be>  <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com> <3A514236.2000801@grips.com> 
To: Kurt Roeckx <Q@ping.be>
Cc: Gerold Jury <geroldj@grips.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel.. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2001 17:25:30 +0000
Message-ID: <12020.978456330@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Q@ping.be said:
>  I'm using the hisax driver too (build in), and it works perfectly for
> me. 

I've also seen my machine die on taking down the ippp0 interface
("service isdn stop") - not on hanging up ("isdnctrl hangup ippp0").

I keep forgetting to investigate, because it's extremely rare that I 
actually disconnect or reboot, rather than just hitting the reset button 
when X has segfaulted again.

Is your machine SMP?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
