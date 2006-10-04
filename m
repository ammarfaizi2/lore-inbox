Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWJDOVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWJDOVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWJDOVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:21:09 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:5852 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1161056AbWJDOVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:21:07 -0400
Date: Wed, 4 Oct 2006 10:20:47 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
Message-ID: <20061004142047.GA30993@csclub.uwaterloo.ca>
References: <451DC75E.4070403@candelatech.com> <m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com> <m3hcyo2qvs.fsf@defiant.localdomain> <45200BD7.6030509@candelatech.com> <1159735586.13029.180.camel@localhost.localdomain> <4523384E.7060806@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4523384E.7060806@candelatech.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:27:58PM -0700, Ben Greear wrote:
> I think you might be right.  It will take some more experimenting to see 
> if they allow
> enough control to read/write bitstreams (clear channel groups in their 
> terminology, I believe) while at
> the same time keeping the timing slots in order...

Sangoma also makes cards with linux drivers, which I suspect will let
you at the low levels if you want to.  They certainly support zaptel
stuff on their cards.  Their hardware is also quite a bit cheaper than
farsite's in my experience.

--
Len Sorensen
