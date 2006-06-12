Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWFLVy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWFLVy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWFLVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:54:58 -0400
Received: from ns.firmix.at ([62.141.48.66]:10656 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932407AbWFLVy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:54:57 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Gerhard Mack <gmack@innerfire.net>, jdow <jdow@earthlink.net>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <m38xo244wz.fsf@defiant.localdomain>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
	 <1150100286.26402.13.camel@tara.firmix.at>
	 <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
	 <Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
	 <m38xo244wz.fsf@defiant.localdomain>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Mon, 12 Jun 2006 23:51:11 +0200
Message-Id: <1150149071.3107.19.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.333 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 20:14 +0200, Krzysztof Halasa wrote:
> Gerhard Mack <gmack@innerfire.net> writes:
> 
> > Look at it from a mail admin's perspective.  The bounces are now going 
> > nowhere instead of some poor user's mailbox.  You have just cut the damage 
> > in half.
> 
> If people doing SPF configured their servers to reject obviously
> bad messages before the SMTP transaction is completed (rather than
> generating a bounce later) it would IMHO do much more good.

In general that's the only sane way to reject detected spam mails (for
whatever the admin defines as "detected spam") - not only if you use
SPF.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

