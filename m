Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143675AbRA1SKD>; Sun, 28 Jan 2001 13:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143720AbRA1SJx>; Sun, 28 Jan 2001 13:09:53 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:63669 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143675AbRA1SJr>;
	Sun, 28 Jan 2001 13:09:47 -0500
Date: Sun, 28 Jan 2001 13:08:40 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: James Sutherland <jas88@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <200101281739.SAA05979@cave.bitwizard.nl>
Message-ID: <Pine.GSO.4.30.0101281307090.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Rogier Wolff wrote:

> jamal wrote:
> > > Yes,
> > > those firewalls should be updated to allow ECN-enabled packets
> > > through. However, to break connectivity to such sites deliberately just
> > > because they are not supporting an *experimental* extension to the current
> > > protocols is rather silly.
> > >
> >
> > This is the way it's done with all protocols. or i should say the way it
> > used to be done. How do you expect ECN to be deployed otherwise?
>
> Thinking about this a bit more:
>
> A sufficiently paranoid firewall should block requests that he doesn't
> fully understand. ECN was in this category, so old firewalls are
> "right" to block these. (Sending an 'RST' is not elegant. So be it.)
>
> However, ECN is now "understood", and operators are now in a position
> to configure their firewall to "do the right thing". This is


This would have been easier. The firewall operators were not provided with
this option. This is hard-coded. I agree with the rest of your message.

cheers,
jamal



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
