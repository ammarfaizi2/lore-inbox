Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVAKEDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVAKEDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVAKEBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:01:03 -0500
Received: from ozlabs.org ([203.10.76.45]:63442 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262486AbVAKEAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:00:03 -0500
Date: Tue, 11 Jan 2005 14:58:10 +1100
From: Anton Blanchard <anton@samba.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
Message-ID: <20050111035810.GG14239@krispykreme.ozlabs.ibm.com>
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111025401.48311.qmail@web51810.mail.yahoo.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I am trying to understand how NetApp can be so much
> better at NFS servicing than my quad Opteron 250 SAN
> attached machine.  So I need some help and some
> pointers to understand how I can make my opteron
> machine come on par (or within 70% NFS performance
> range) as that of my NetApp R200.  I have run through
> the NFS-how-to's and have heard "that is why they cost
> so much more", but I really have to consider that
> probably most of the ideas that are in the NetApp are
> common knowldge (just not in my head).
> 
> Can anyone shed some light on this?

Definitely sounds like something is wrong. You can do your own
comparisons of Linux 2.6 vs Netapp here (the OpenPower 720 is a ppc64
Linux box):

http://www.spec.org/sfs97r1/results/sfs97r1.html

Anton
