Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTEMRiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEMRiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:38:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:55702 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262410AbTEMRiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:38:03 -0400
Date: Tue, 13 May 2003 18:50:22 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Vesa fix
Message-ID: <20030513175022.GA3309@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:44:29PM +0100, James Simmons wrote:

 >    The results of the EDID info from the BIOS has been varied. For some it 
 > worked. Others it gave the wrong data. Then for other even the headers 
 > where corrupted :-( 

XFree86 seems to do a pretty good job of getting it right, maybe they
have blacklists ? Then again, this stuff is arguably better off done
in userspace anyway IMO.

		Dave

