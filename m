Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131449AbRCPXqq>; Fri, 16 Mar 2001 18:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbRCPXq0>; Fri, 16 Mar 2001 18:46:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47113 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131430AbRCPXqS>; Fri, 16 Mar 2001 18:46:18 -0500
Date: Fri, 16 Mar 2001 19:00:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Cc: linux-kernel@vger.kernel.org, andrewm@uow.edu.au, kaos@ocs.com.au
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <3AB23D6A.E0B072C8@digitalimpact.com>
Message-ID: <Pine.LNX.4.21.0103161849100.5687-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Mar 2001, Shane Y. Gibson wrote:

> Marcelo Tosatti wrote:
> >
> > Can you please try to reproduce it with the following patch against 2.4.2?
> 
> Marcelo (et al),
> 
> I'll give it a whirl with the patch.  Should I also
> try setting `nmi_watchdog=0' in lilo.conf, as Andrew
> Morton suggests?

Andrew's suggestion may avoid the machine from getting frozen (which makes
your life easier :)).

The oops message will appear with or without the nmi watchdog. 

> 
> Additionally, I'll upgrade my version of ksymoops.
> Unfortunately, I won't get a chance to test all of
> this until Monday; at which time I'll report back to
> the group.

Ok. We're waiting :)

Thanks.

