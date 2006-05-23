Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWEWSlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWEWSlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWEWSlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:41:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49848 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932252AbWEWSlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:41:09 -0400
Subject: Re: Compact Flash Serial ATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Russell McConnachie <russell.mcconnachie@guest-tek.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060523172352.GD9528@one-eyed-alien.net>
References: <1148379397.1182.4.camel@gt-alphapbx2>
	 <20060523172352.GD9528@one-eyed-alien.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 19:54:49 +0100
Message-Id: <1148410489.25255.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 10:23 -0700, Matthew Dharm wrote:
> I don't know if this is the right fix (if nothing else the patch needs to
> be sent in unified diff format), but it's certainly something that needs
> fixing.

I sent Jeff the patch to fix that a few days ago. Jeff can probably tell
you if its been applied yet. If not grab the libata PATA patches as they
include the needed fixes for 2.6.17-rc. The 2.6.17-mm tree is a bit
different so may be ok anyway.

