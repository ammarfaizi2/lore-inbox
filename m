Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271278AbTGWULg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTGWUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:08:55 -0400
Received: from bms.ne.client2.attbi.com ([24.62.163.168]:28631 "EHLO
	ns.briggsmedia.com") by vger.kernel.org with ESMTP id S271278AbTGWUIZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:08:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joe Briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: paterley <paterley@DrunkenCodePoets.com>, Jason <jason@project-lace.org>
Subject: Re: AMD MP, SMP, Tyan 2466
Date: Wed, 23 Jul 2003 16:03:43 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <BB41BCD3.17A02%kernel@mousebusiness.com> <1058846559.8494.17.camel@big-blue.project-lace.org> <20030723081946.44d4fe10.paterley@DrunkenCodePoets.com>
In-Reply-To: <20030723081946.44d4fe10.paterley@DrunkenCodePoets.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307231603.43543.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyan publishes a list of tested memory chips for this board on their website.  
I tried the AOPEN ECC memory and it did not work.

On Wednesday 23 July 2003 08:19 am, paterley wrote:
> On 22 Jul 2003 00:02:39 -0400
>
> Jason <jason@project-lace.org> wrote:
> > Hello,
> >
> > I'm coming into this conversation a bit late, so I might be missing
> > something and appologize if I am.  But  I have the same board and
> > experienced some intersting weirdness with PC2100 NON ECC chips on this
> > board as well.  I was using High performance ram from Mushkin at the
> > time.  Now here's the interesting part, according to some small print in
> > the manual, non ecc ram works up to 1.5Gb.  Knowing this, I bought 1Gb
> > of it, 2 512MB sticks.  I put them both in, and the board only sees
> > 512Mb.  So I talk to Mushkin about it, apparently they've done some
> > testing with this board.  Non ECC memory is EXTREMELY flakey in this
> > board.  So flakey that Tyan, unofficially mind you, recommened to them
> > that they not suggest to their customers to put non ecc memory in this
> > board.  So I got 1Gb of ECC Registered memory, and have yet to have a
> > problem with it.
>
> Actually, your 2 dimm problem could have (probably) been solved by
> rearranging your dimms.  I have the 2462ung (thunder k7) and the only way I
> could get 512 megs (give me a break I'm a porr college student) was to put
> one in slot 1 and one in slot 3 (numbering starting at 0).
>
> Pat Erley--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 03104 USA
TEL/FAX 603 232 3115
www.briggsmedia.com
