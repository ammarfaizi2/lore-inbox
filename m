Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCABR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCABR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVCABR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:17:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:38787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbVCABQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:16:54 -0500
Date: Mon, 28 Feb 2005 17:17:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: brugolsky@telemetry-investments.com, SteveD@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client O_DIRECT oops
In-Reply-To: <20050228170016.0c26a109@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502281716490.25732@ppc970.osdl.org>
References: <42236AC6.6000609@RedHat.com> <20050228170016.0c26a109@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Pete Zaitcev wrote:
> 
> This is how I think it should have been fixed:

Since this seems a cleanup, I'll drop it for now. Can you re-send after 
2.6.11 (or forward it to the nfs people) so that it gets cleaned up at 
some point? I do agree that your patch seems to be cleaner.

		Linus
