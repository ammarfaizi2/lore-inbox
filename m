Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVBOUlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVBOUlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVBOUlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:41:02 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:34316 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261871AbVBOUgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:36:05 -0500
Date: Tue, 15 Feb 2005 21:35:54 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 10/13] Solaris nfsacl workaround
Message-ID: <20050215203553.GA34621@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20050122203326.402087000@blunzn.suse.de> <20050122203619.889966000@blunzn.suse.de> <1108488547.10073.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108488547.10073.39.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 12:29:06PM -0500, Trond Myklebust wrote:
> lau den 22.01.2005 Klokka 21:34 (+0100) skreiv Andreas Gruenbacher:
> > Solaris nfsacl workaround
> 
> NACK. No hacks.

That's the second time I see you refusing an interoperability patch
without bothering to say what would be acceptable.  Do we need a fork
between knfsd-pure and knfsd-actually-works-in-the-real-world or what?

  OG.

