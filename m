Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTFAALD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 20:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTFAALC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 20:11:02 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:1957 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264523AbTFAALC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 20:11:02 -0400
Date: Sun, 1 Jun 2003 01:27:19 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gutko <gutko@poczta.onet.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21rc6-ac1 Nforce2 AGP+ATI FireGL v2.9.12=hard lock
Message-ID: <20030601002719.GA30771@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Gutko <gutko@poczta.onet.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3ED8E682.5020506@poczta.onet.pl> <1054423040.28853.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054423040.28853.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 12:17:23AM +0100, Alan Cox wrote:
 > On Sad, 2003-05-31 at 18:29, Gutko wrote:
 > > During install of this rpm i get something like this:
 > > "Patching drmP.h  FAILED, saving rejects to....."
 > > This *.rej file is in attachment.
 > > Then module loads normally. I can start X on this driver, but only in 2d.
 > > Trying to run Tuxracer and any other 3d game hardlocks my machine. 2d 
 > > games works ok.
 > 
 > If it patches the kernel then I wouldnt be suprised if the patches are
 > not compatible

Worse yet, it has its own bastardised agpgart support also.

		Dave

