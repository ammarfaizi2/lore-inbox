Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVCaE3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVCaE3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 23:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCaE3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 23:29:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261951AbVCaE33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 23:29:29 -0500
Date: Wed, 30 Mar 2005 23:29:23 -0500
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sean <seandarcy2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
Message-ID: <20050331042923.GB23124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	sean <seandarcy2@gmail.com>, linux-kernel@vger.kernel.org
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org> <424B79E6.90300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B79E6.90300@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 11:17:42PM -0500, Jeff Garzik wrote:
 > >with the requirement (for me) that I not be required to use BK?
 > >I'll munge scripts or whatever...
 > >but I guess that I'll also need a kernel.org account to do that.
 > 
 > Should hopefully just be changing get-version.pl ...

hmm, it's going to go a bit nutso when it finds the most
recent TAG: is from the bk pull of 2.6.11.x into Linus tree.
So it generates -bk from /that/ instead of 2.6.12.

Could hack around it by checking the cset is from Linus I suppose ?

 > 	Jeff, still catching up from trip+engagement

Congrats!

		Dave
 
