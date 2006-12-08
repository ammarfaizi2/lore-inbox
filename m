Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425422AbWLHLvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425422AbWLHLvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938052AbWLHLvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:51:22 -0500
Received: from styx.suse.cz ([82.119.242.94]:43481 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S938051AbWLHLvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:51:21 -0500
Date: Fri, 8 Dec 2006 12:51:17 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
X-X-Sender: jkosina@jikos.suse.cz
To: Andrew Morton <akpm@osdl.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dtor@insightbb.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [git pull] Input patches for 2.6.19
In-Reply-To: <20061208030755.4ae3d5df.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612081248210.4215@jikos.suse.cz>
References: <200612080157.04822.dtor@insightbb.com>
 <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz> <1165579184.5529.33.camel@aeonflux.holtmann.net>
 <20061208030755.4ae3d5df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Andrew Morton wrote:

> > > Greg, should I prepare a new version of the generic HID patches against 
> > > merged Linus' + Dmitry's trees and send them to you?
> > yes please, because Linus already merged Dmitry's patches.
> I suggest that you leave it for 12 hours - there's a lot more stuff in flight and
> there might be overlaps.

OK. Could you please let me know when all these are merged? I have already 
rebased all the patches against current Linus' tree (with Dmitry's tree 
merged), but will hold on until I get green light from you, and then send 
this again to Greg - Greg, is that fine by you?

Thanks,

-- 
Jiri Kosina
