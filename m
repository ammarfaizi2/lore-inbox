Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUJKNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUJKNpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUJKNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:45:22 -0400
Received: from nef.ens.fr ([129.199.96.32]:47890 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S268954AbUJKNpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:45:15 -0400
Subject: Re: possible GPL violation by Free
From: Eric Rannaud <eric.rannaud@ens.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20041011091411.1335746c@pirandello>
References: <1097456379.27877.51.camel@frenchenigma>
	 <20041011091411.1335746c@pirandello>
Content-Type: text/plain
Date: Mon, 11 Oct 2004 15:45:08 +0200
Message-Id: <1097502309.27877.124.camel@frenchenigma>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Mon, 11 Oct 2004 15:45:14 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 09:14 +0200, Colin Leroy wrote:
> Hi,
> 
> I think you just scanned the router, or whatever network appliance it is,
> behind the freebox :-)
> 
> The freebox is quite transparent when it's plugged to the network. Try to 
> just plug in to your computer and assign it an IP using arp -s...
> 
> (not sure, however)

Ermmm, indeed, that's quite possible :-{ I've been lured by the MAC
address, which was correct. But that didn't mean anything.
The problem is that once the freebox is disconnected from the xDSL line,
it becomes completely silent on the network. nmap -O -P0 is meaningless.

It does seem to act like a bridge, indeed.

Mathieu wrote:
> Are you sure you don't scan your computer : the freebox v1 don't have
> router mode and act like a bridge.

No, my computer doesn't look like that.

I have asked Free for more information about the OS running on the
freebox. I don't know what kind of tests could be performed on such a
device. If you have any suggestion.

   /er.

-- 
Eric Rannaud <eric.rannaud@ens.fr>
http://www.eleves.ens.fr/home/rannaud/

