Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWFLSOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWFLSOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWFLSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:14:54 -0400
Received: from khc.piap.pl ([195.187.100.11]:48811 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751646AbWFLSOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:14:53 -0400
To: Gerhard Mack <gmack@innerfire.net>
Cc: jdow <jdow@earthlink.net>, Bernd Petrovitsch <bernd@firmix.at>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<00de01c68df9$7d2b2330$0225a8c0@Wednesday>
	<Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 12 Jun 2006 20:14:52 +0200
In-Reply-To: <Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net> (Gerhard Mack's message of "Mon, 12 Jun 2006 13:37:46 -0400 (EDT)")
Message-ID: <m38xo244wz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> writes:

> Look at it from a mail admin's perspective.  The bounces are now going 
> nowhere instead of some poor user's mailbox.  You have just cut the damage 
> in half.

If people doing SPF configured their servers to reject obviously
bad messages before the SMTP transaction is completed (rather than
generating a bounce later) it would IMHO do much more good.
-- 
Krzysztof Halasa
