Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143960AbRA1Tp6>; Sun, 28 Jan 2001 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144020AbRA1Tps>; Sun, 28 Jan 2001 14:45:48 -0500
Received: from [63.95.87.168] ([63.95.87.168]:28684 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143960AbRA1Tpg>;
	Sun, 28 Jan 2001 14:45:36 -0500
Date: Sun, 28 Jan 2001 14:45:35 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Ben Ford <ben@kalifornia.com>
Cc: James Sutherland <jas88@cam.ac.uk>, jamal <hadi@cyberus.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
Message-ID: <20010128144535.D13195@xi.linuxpower.cx>
In-Reply-To: <Pine.SOL.4.21.0101280852470.14226-100000@green.csi.cam.ac.uk> <3A7426E1.728BB87D@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3A7426E1.728BB87D@kalifornia.com>; from ben@kalifornia.com on Sun, Jan 28, 2001 at 06:04:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 06:04:17AM -0800, Ben Ford wrote:
> James Sutherland wrote:
[snip] 
> > those firewalls should be updated to allow ECN-enabled packets
> > through. However, to break connectivity to such sites deliberately just
> > because they are not supporting an *experimental* extension to the current
> > protocols is rather silly.
> 
> Do keep in mind, we aren't breaking connectivity, they are.

Thats the crux of the argument. No one made them run a firewall, they chose
one that blocks undefined behavior. The Internet is a dynamic system, they
broke the end-to-end model with their firewall, the onus is on them to keep
up.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
