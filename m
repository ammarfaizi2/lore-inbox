Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCCOIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCCOIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCCOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:08:25 -0500
Received: from levante.wiggy.net ([195.85.225.139]:2234 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261678AbVCCOIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:08:23 -0500
Date: Thu, 3 Mar 2005 15:08:21 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303140820.GD31559@wiggy.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <4226EE0F.1050405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4226EE0F.1050405@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jeff Garzik wrote:
> We need to send a clear signal to users "this is when you can really 
> start hammering it."  A signal that does not change from release to 
> release.  A signal that does not require intimate knowledge of the 
> kernel devel process.

The problem I see with that is that the majority is going to wait until
one or two releases after that point since the first 'stablization
point' since that the first such release will not have received much
testing yet. Just like the .0 release for a lot of projects turns
out to a beta version even though they had a seperate beta test.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
