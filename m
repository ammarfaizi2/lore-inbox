Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143896AbRA1US7>; Sun, 28 Jan 2001 15:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144111AbRA1USu>; Sun, 28 Jan 2001 15:18:50 -0500
Received: from [63.95.87.168] ([63.95.87.168]:40204 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143896AbRA1USg>;
	Sun, 28 Jan 2001 15:18:36 -0500
Date: Sun, 28 Jan 2001 15:18:35 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: jamal <hadi@cyberus.ca>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, James Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010128151835.G13195@xi.linuxpower.cx>
In-Reply-To: <200101281739.SAA05979@cave.bitwizard.nl> <Pine.GSO.4.30.0101281307090.24762-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.GSO.4.30.0101281307090.24762-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 28, 2001 at 01:08:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 01:08:40PM -0500, jamal wrote:
> On Sun, 28 Jan 2001, Rogier Wolff wrote:
> 
> > A sufficiently paranoid firewall should block requests that he doesn't
> > fully understand. ECN was in this category, so old firewalls are
> > "right" to block these. (Sending an 'RST' is not elegant. So be it.)
> >
> > However, ECN is now "understood", and operators are now in a position
> > to configure their firewall to "do the right thing". This is
> 
> This would have been easier. The firewall operators were not provided with
> this option. This is hard-coded. I agree with the rest of your message.

They chose their vendor. 

In the case of Cisco, they aparently chose OK as cisco fixed their product
right away.

In the case of Raptor they made a bad decision as the vendor still has not
fixed the problem...

They could have chose Linux where if there had been an issue they could have
gotten it fixed without respect to the vendors idea of how important the
problem is...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
