Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTLRSWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbTLRSWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:22:03 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:19623 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265258AbTLRSWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:22:01 -0500
Date: Thu, 18 Dec 2003 18:21:41 +0000
From: Dave Jones <davej@redhat.com>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buffalo Airstation
Message-ID: <20031218182141.GA12734@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org
References: <3FE1DC69.9050704@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE1DC69.9050704@jonmasters.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 04:57:13PM +0000, Jon Masters wrote:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > Hi there,
 > 
 > I made some progress getting up to date code from Buffalo today, after I
 > called them, in getting a link to the older source and information about
 > the forthcoming new release. Apparently they are having a meeting on
 > January 6 to try to push forward a new release soon thereafter.
 > 
 > http://www2.melcoinc.co.jp/pub/lan/linux_src.tgz

http://www.linux.org.uk/~davej/buffalo.diff.gz

Quite amusing as the bulk of the diff seems to be
a) XFS merge (came in from SGI as the original tree seems to
   be cloned from the linux-mips tree).
b) Someone seems to have gone right through the 2.4.5 tree
   deleting every comment with FIXME/XXX in it, along with
   anything #if'd out.

		Dave

