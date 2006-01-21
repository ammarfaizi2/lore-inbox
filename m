Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWAUWrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWAUWrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAUWrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:47:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22945 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751213AbWAUWrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:47:20 -0500
Subject: Re: Development tree, PLEASE?
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
	 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
	 <1137829140.3241.141.camel@mindpipe>
	 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
	 <1137881882.411.23.camel@mindpipe>
	 <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 17:47:18 -0500
Message-Id: <1137883638.411.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 15:40 -0700, Michael Loftis wrote:
> I don't feel that statement is true in all cases.  It's true in a lot
> of cases yes, but sometimes 'support' is really simply a matter of
> techinga module one more PCI ID.  

That might be true for server class hardware where the vendors care
about the stability of the hardware platform, but for modern desktop
stuff like sound cards it's never that simple.  Desktop class hardware
is getting dumber and dumber all the time as more features are pushed
into software which makes adding support for new devices tricky, and new
devices are introduced constantly.  Sometimes they'll even ship 2 models
with the same PCI IDs but a different chipset, so you have to use some
other kludge to know what to do.  Etc.

Lee

