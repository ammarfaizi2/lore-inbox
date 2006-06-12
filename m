Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWFLTQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFLTQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFLTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:16:17 -0400
Received: from khc.piap.pl ([195.187.100.11]:39359 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932103AbWFLTQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:16:15 -0400
To: "jdow" <jdow@earthlink.net>
Cc: "Gerhard Mack" <gmack@innerfire.net>,
       "Bernd Petrovitsch" <bernd@firmix.at>, <davids@webmaster.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	<193701c68d16$54cac690$0225a8c0@Wednesday>
	<1150100286.26402.13.camel@tara.firmix.at>
	<00de01c68df9$7d2b2330$0225a8c0@Wednesday>
	<Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
	<m38xo244wz.fsf@defiant.localdomain>
	<01bb01c68e50$93753de0$0225a8c0@Wednesday>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 12 Jun 2006 21:16:13 +0200
In-Reply-To: <01bb01c68e50$93753de0$0225a8c0@Wednesday> (jdow@earthlink.net's message of "Mon, 12 Jun 2006 11:46:53 -0700")
Message-ID: <m3ver62nia.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"jdow" <jdow@earthlink.net> writes:

> Krzysztof, the point here is that experience with active spam
> filtering indicates that there is no such thing as "obviously bad
> messages" that will not catch some good messages in its broad
> brush.

Sure, but if someone bounces a message for whatever reason I assume
it's (at that point) obviously bad. It doesn't necessarily means
spam, it might as well be a "detected virus", "user unknown" etc.
And yes, you can usually reject them in SMTP session. Doing that
fixes a real problem.
-- 
Krzysztof Halasa
