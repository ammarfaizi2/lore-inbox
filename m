Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbRFMOyo>; Wed, 13 Jun 2001 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRFMOye>; Wed, 13 Jun 2001 10:54:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46860 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263948AbRFMOyZ>;
	Wed, 13 Jun 2001 10:54:25 -0400
Date: Wed, 13 Jun 2001 15:53:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Keith Owens <kaos@ocs.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
Message-ID: <20010613155352.B21143@flint.arm.linux.org.uk>
In-Reply-To: <15143.29246.712747.936864@pizda.ninka.net> <10322.992441398@ocs4.ocs-net> <15143.30453.762432.702411@pizda.ninka.net> <jek82gjv6v.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <jek82gjv6v.fsf@sykes.suse.de>; from schwab@suse.de on Wed, Jun 13, 2001 at 04:44:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2001 at 04:44:40PM +0200, Andreas Schwab wrote:
> Use %c0.  *Note Output Templates and Operand Substitution: (gcc)Output
> Template.

Oh great!  I can get rid of some more crap from the ARM tree!

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

