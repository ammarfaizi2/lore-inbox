Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUJTOmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUJTOmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUJTOjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:39:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28171 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266574AbUJTOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:34:24 -0400
Date: Wed, 20 Oct 2004 15:34:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Rate of change
Message-ID: <20041020153416.E14627@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41758410.2020200@pobox.com> <20041019213758.GE22334@redhat.com> <20041019213932.GA7383@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041019213932.GA7383@havoc.gtf.org>; from jgarzik@pobox.com on Tue, Oct 19, 2004 at 05:39:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 05:39:32PM -0400, Jeff Garzik wrote:
> On Tue, Oct 19, 2004 at 05:37:59PM -0400, Dave Jones wrote:
> > On Tue, Oct 19, 2004 at 05:16:00PM -0400, Jeff Garzik wrote:
> >  > 
> >  > 850 changesets and 3383 revisions since 2.6.9 was released,
> >  > a little over 24 hours ago.
> >  > 
> >  > That's pretty impressive.
> > 
> > Given a lot of these are backlogs from folks being
> > conservative whilst we were in -rc, perhaps this is an
> > indication we need shorter -rc periods ?
> 
> 
> Actually, we need longer non-rc periods :)

Personally, I think both of you are right.  One major kernel release a
month seemed to be about the right rate.  Maybe a week and a half of
non-rc plus two and a half weeks of -rc would be the right kind of
balance?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
