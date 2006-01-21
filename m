Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWAUWzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWAUWzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWAUWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:55:44 -0500
Received: from ns.firmix.at ([62.141.48.66]:34541 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751217AbWAUWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:55:44 -0500
Subject: Re: Development tree, PLEASE?
From: Bernd Petrovitsch <bernd@firmix.at>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Michael Loftis <mloftis@wgops.com>, Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <1137883638.411.38.camel@mindpipe>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
	 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
	 <1137829140.3241.141.camel@mindpipe>
	 <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de>
	 <1137881882.411.23.camel@mindpipe>
	 <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com>
	 <1137883638.411.38.camel@mindpipe>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sat, 21 Jan 2006 23:51:28 +0100
Message-Id: <1137883888.3291.53.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 17:47 -0500, Lee Revell wrote:
> On Sat, 2006-01-21 at 15:40 -0700, Michael Loftis wrote:
> > I don't feel that statement is true in all cases.  It's true in a lot
> > of cases yes, but sometimes 'support' is really simply a matter of
> > techinga module one more PCI ID.  
> 
> That might be true for server class hardware where the vendors care
> about the stability of the hardware platform, but for modern desktop
> stuff like sound cards it's never that simple.  Desktop class hardware
> is getting dumber and dumber all the time as more features are pushed
> into software which makes adding support for new devices tricky, and new
> devices are introduced constantly.  Sometimes they'll even ship 2 models
> with the same PCI IDs but a different chipset, so you have to use some
> other kludge to know what to do.  Etc.

And the more the development head proceeds from the "stable" one, the
more work is it to "backport" some hardware driver IMHO. Especially if
"stability" is a primary concern.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



