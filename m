Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVCBSf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVCBSf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVCBSf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:35:27 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:53305 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S262189AbVCBSfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:35:18 -0500
X-ME-UUID: 20050302183517979.EF2C41C000B7@mwinf1204.wanadoo.fr
Date: Wed, 2 Mar 2005 19:35:11 +0100
From: Christophe Lucas <clucas@rotomalug.org>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050302183511.GA20545@rhum.iomeda.fr>
References: <200503021236.26561.ks@cs.aau.dk> <200503021459.39846.ks@cs.aau.dk> <200503021842.j22IgIBY012680@ccure.user-mode-linux.org> <200503021809.59747.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503021809.59747.ks@cs.aau.dk>
X-Operating-System: Debian GNU/Linux / 2.6.9 (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 192.168.0.24
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: Re: UserMode bug in 2.6.11-rc5? autolearn=disabled version=3.0.2
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on vodka.iomeda.fr)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen (ks@cs.aau.dk) wrote:
> On Wednesday 02 March 2005 19:42, Jeff Dike wrote:
> > ks@cs.aau.dk said:
> > > Hey! Thanks - that fixed the problem! :-D
> >
> > Didn't you say this this setup worked with 2.6.10?  That's why I didn't
> > suggest staring at /etc/inittab.
> Yes - it works fine with 2.6.10. Does anyone of you know why/where the change 
> was?

For my part, I have made this changes on a 2.6.9 kernel to make it work
about this problem.

	~Christophe

