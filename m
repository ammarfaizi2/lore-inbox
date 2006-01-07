Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWAGW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWAGW1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWAGW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:27:17 -0500
Received: from quechua.inka.de ([193.197.184.2]:54463 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161028AbWAGW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:27:16 -0500
Date: Sat, 7 Jan 2006 23:27:13 +0100
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060107222713.GA22450@lina.inka.de>
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de> <20060105111105.GK20809@redhat.com> <20060107214439.GA13433@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060107214439.GA13433@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:44:39PM -0800, Kurtis D. Rader wrote:
> Great! Only problem is the info we really need has already scrolled of the
> screen. An option to pause briefly after each boot time printk would be very
> useful.

I dont think so. It is too much to read to an supporter by phone, and
somebody who can diag that self knows exactly where the root is searched in
his config. After all it can only be a hardware or driver problem.

I think it makes much more sense to allow scrollback than to delay
printouts. (And I am quite sure scrollback works in this case)

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
