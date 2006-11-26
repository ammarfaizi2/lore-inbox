Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755488AbWKZT2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbWKZT2m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755495AbWKZT2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:28:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11141 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755488AbWKZT2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:28:41 -0500
From: Andi Kleen <ak@suse.de>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Date: Sun, 26 Nov 2006 20:28:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de> <20061126131532.GA41703@dspnet.fr.eu.org>
In-Reply-To: <20061126131532.GA41703@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611262028.04638.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 14:15, Olivier Galibert wrote:
> Ok, here you go, what about that?  I'll be able to test it on i386 on
> monday, not before.  It's hard to doa full 32bits install remotely :-)

Sorry, please don't put it all into a single patch. Do one patch
that just moves code, then add new functionality later.
Otherwise nobody can review it properly.

-Andi
