Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUHBVAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUHBVAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUHBVAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:00:49 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:56477 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263448AbUHBVAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:00:48 -0400
Message-ID: <20040802210048.5071.qmail@web14928.mail.yahoo.com>
Date: Mon, 2 Aug 2004 14:00:48 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200408021002.31117.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> It it suitable for the mainline yet?  I expect those familiar with 
> the various cards to add the necessary quirks code as needed.

Is tracking the boot video device and redirecting to C000:0 going to be
a quirk, architecture specific, or what? Where does this little piece
of code need to go?

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
