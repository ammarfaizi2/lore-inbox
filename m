Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143692AbRA1SYH>; Sun, 28 Jan 2001 13:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143758AbRA1SXr>; Sun, 28 Jan 2001 13:23:47 -0500
Received: from 13dyn128.delft.casema.net ([212.64.76.128]:50445 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S143692AbRA1SXc>; Sun, 28 Jan 2001 13:23:32 -0500
Message-Id: <200101281823.TAA06080@cave.bitwizard.nl>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.GSO.4.30.0101281307090.24762-100000@shell.cyberus.ca> from
 jamal at "Jan 28, 2001 01:08:40 pm"
To: jamal <hadi@cyberus.ca>
Date: Sun, 28 Jan 2001 19:23:28 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, James Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> 
> On Sun, 28 Jan 2001, Rogier Wolff wrote:
> 
> > jamal wrote:
> > > > Yes,
> > > > those firewalls should be updated to allow ECN-enabled packets
> > > > through. However, to break connectivity to such sites deliberately just
> > > > because they are not supporting an *experimental* extension to the current
> > > > protocols is rather silly.
> > > >
> > >
> > > This is the way it's done with all protocols. or i should say the way it
> > > used to be done. How do you expect ECN to be deployed otherwise?
> >
> > Thinking about this a bit more:
> >
> > A sufficiently paranoid firewall should block requests that he doesn't
> > fully understand. ECN was in this category, so old firewalls are
> > "right" to block these. (Sending an 'RST' is not elegant. So be it.)
> >
> > However, ECN is now "understood", and operators are now in a position
> > to configure their firewall to "do the right thing". This is

> This would have been easier. The firewall operators were not
> provided with this option. This is hard-coded. I agree with the rest
> of your message.

Take "configure" with a bit of liberty. Because the firewall vendor
chose to hard-code this into the firmware. "configuring" in this case
means reconfiguring new software on the firewall. Blame the vendor. 

			Roger. 




-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
