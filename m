Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135291AbQK0CUK>; Sun, 26 Nov 2000 21:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135347AbQK0CTu>; Sun, 26 Nov 2000 21:19:50 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59152 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S135345AbQK0CTq>; Sun, 26 Nov 2000 21:19:46 -0500
Date: Sun, 26 Nov 2000 19:46:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Ford <david@linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126194643.E2265@vger.timpanogas.org>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org> <3A21968B.5CDB12BF@haque.net> <20001126170334.B1787@vger.timpanogas.org> <3A21A7D9.9CE7077B@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A21A7D9.9CE7077B@linux.com>; from david@linux.com on Sun, Nov 26, 2000 at 04:16:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 04:16:26PM -0800, David Ford wrote:
> "Jeff V. Merkey" wrote:
> 
> > On Sun, Nov 26, 2000 at 06:02:35PM -0500, Mohammad A. Haque wrote:
> > > I'd rather have Anaconda changed rather than special casing standard
> > > utils to account for distro handling.
> >
> > Great.  Then tell RedHat to rewrite it without the need for these switches.
> > They will say NO.  It's a trivial change, and would save me a lot of hours
> > rewriting scripts.  I did it once, but if RedHat has standardized on this
> > set of switches, why not add them as alias commands?  It's a trivial
> > patch.
> 
> Then let RedHat maintain their version of modutils.  RedHat isn't the
> standard, nor should RedHat dictate to authors, nor should other distributions
> and persons be affected by RedHat's methods.
> 
> If you don't like it, replace your depmod with a script that strips that flag
> before calling the original depmod.

Anaconda is open sourced, so it's not technically tied to any one 
distributor any more....

Jeff

> 
> -d
> 

Content-Description: Card for David Ford

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
