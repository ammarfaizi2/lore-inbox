Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTEOPNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTEOPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:12:48 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:7331 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264080AbTEOPLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:11:36 -0400
Date: Thu, 15 May 2003 16:25:14 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030515152514.GB6724@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@muc.de>, kraxel@suse.de, jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <20030515152011.GA19271@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515152011.GA19271@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 05:20:11PM +0200, Andi Kleen wrote:

 > > There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
 > > we can work around them with a quirk.  I have one *somewhere*, but it'll
 > > take me a while to dig it out.
 > 
 > To make all 0.001 users left of them happy yes. I think the patch should
 > be applied anyways.

Agreed.

		Dave

