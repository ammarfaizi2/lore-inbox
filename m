Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTGBSMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTGBSMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:12:09 -0400
Received: from bacchus.optics.arizona.edu ([128.196.206.37]:55523 "EHLO
	bacchus.optics.arizona.edu") by vger.kernel.org with ESMTP
	id S264115AbTGBSMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:12:07 -0400
Date: Wed, 2 Jul 2003 11:22:49 -0700
From: John Lapeyre <lapeyre@physics.arizona.edu>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] USB updates for 2.4.21
Message-ID: <20030702182249.GA11236@bacchus.optics.arizona.edu>
Reply-To: lapeyre@physics.arizona.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Re: From: Greg KH (greg@kroah.com)
    Date: Thu Jun 19 2003 - 19:40:35 EST 

Broken ehci-hcd things seem to be fixed with this patch. I had
numerous crashes, hangs, filesystem corruption, etc. with
 2.4.19,20,21 until I applied this. I am using,

 DVD burner in an external USB 2.0  enclosure (same as the one rebranded by Belkin)
 IDE drive in the same model enclosure.
 Epson 3200 scanner.

 Using them before the patch, particularly simultaneously, caused driver crashes. They
 seem to share the bus nicely now.

 Please CC me with replies.
John lapeyre http://physics.arizona.edu/~lapeyre
