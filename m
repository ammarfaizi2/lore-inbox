Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVAaXC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVAaXC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVAaXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:02:56 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:64458 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261418AbVAaXCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:02:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.10-ac11 announcement?
Date: Tue, 1 Feb 2005 00:02:49 +0100
User-Agent: KMail/1.7.1
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050129191235.GG14791@charite.de> <1107158722.14787.68.camel@localhost.localdomain>
In-Reply-To: <1107158722.14787.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502010002.50734.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of January 2005 09:05, Alan Cox wrote:
> On Sad, 2005-01-29 at 19:12, Ralf Hildebrandt wrote:
> > Where is the 2.6.10-ac11 announcement?
> 
> Good question
> 
> Arjan van de Ven is now building RPMS of the kernel and those can be found
> in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
> diff a little as the RPM builds and tests do take time.
> 
> Nothing terribly exciting here security wise but various bugs for problems
> people have been hitting that are now fixed upstream, and also the ULi
> tulip variant should now work. If you are running IPv6 you may well want
> the networking fixes.

Is there a broken-out version of the patch available?  It reboots at startup
(before it mounts the root fs) on my dual-Opteron box (SuSE 9.2), but -ac10
works fine, evidently.  I could check which changeset actually caused this to
happen, but I'd need to separate them.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
