Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTEZRLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTEZRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:11:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24755 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261808AbTEZRK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:10:58 -0400
Date: Mon, 26 May 2003 19:24:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526172405.GJ845@suse.de>
References: <3ED1B261.8030708@pobox.com> <Pine.LNX.4.44.0305260956590.11328-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305260956590.11328-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Linus Torvalds wrote:
> > What does the block layer need, that it doesn't have now?
> 
> Exactly. I'd _love_ for people to really think about this.

In discussion with Jeff, it seems most of what he wants is already
there. He just doesn't know it yet :-)

Maybe that's my problem as well, maybe the code / comments / doc /
whatever is not clear enough.

-- 
Jens Axboe

