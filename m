Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUHYTDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUHYTDd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUHYTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:03:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41391 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268279AbUHYTDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:03:32 -0400
Date: Wed, 25 Aug 2004 12:03:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: joshk@triplehelix.org, rddunlap@osdl.org, lcaron@apartia.fr,
       linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040825120301.0f396eb0.davem@redhat.com>
In-Reply-To: <200408251034.59717.oliver@neukum.org>
References: <412B5B35.7020701@apartia.fr>
	<20040824233648.53eb7c30.davem@redhat.com>
	<412C442D.3090107@triplehelix.org>
	<200408251034.59717.oliver@neukum.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 10:34:59 +0200
Oliver Neukum <oliver@neukum.org> wrote:

> Am Mittwoch, 25. August 2004 09:47 schrieb Joshua Kwan:
> > I'm not clear on the details but what they seem to have deduced is that
> > as long as the firmware 'variable' is not shipped into Debian as part of
> > the compiled tg3.o, it's barely Free. See
> > 
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=243044
> > 
> > for details of the loophole. To me, it makes no difference...
> 
> And it really strains the meaning of "bugreport"

And I have to assume that you guys did the same thing to the
qlogic scsi drivers too?  That should wipe out about half of
the ia64 boxes out there, ROFL!
