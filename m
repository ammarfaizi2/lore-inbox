Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272258AbRHXQrz>; Fri, 24 Aug 2001 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272260AbRHXQrn>; Fri, 24 Aug 2001 12:47:43 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:43724 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S272258AbRHXQrf>; Fri, 24 Aug 2001 12:47:35 -0400
Date: Fri, 24 Aug 2001 17:47:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@suse.de>
Cc: Padraig Brady <Padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] CPU temperature control
Message-ID: <20010824174748.F31722@flint.arm.linux.org.uk>
In-Reply-To: <3B86771E.3050207@AnteFacto.com> <Pine.LNX.4.30.0108241801420.14354-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0108241801420.14354-100000@Appserv.suse.de>; from davej@suse.de on Fri, Aug 24, 2001 at 06:06:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 06:06:00PM +0200, Dave Jones wrote:
> So far, there are several implementations in there, in various stages
> of completion. The various x86 types need finishing, and it'll be
> ready (as long as rmk has nothing else to add to it) for submission.

I don't have anything to add to the generic layer; it needs a little
cleanup to remove the "this is debug only" comments against the proc
interface.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

