Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDJVSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDJVSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVDJVSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:18:21 -0400
Received: from orb.pobox.com ([207.8.226.5]:28851 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261608AbVDJVSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:18:18 -0400
Date: Sun, 10 Apr 2005 14:18:08 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mjg59@scrf.ucam.org, hare@suse.de
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050410211808.GA12118@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net> <20050408103327.GD1392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408103327.GD1392@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry I took so long to respond. I was busy with tons of stuff
offline...)

On Fri, Apr 08, 2005 at 12:33:27PM +0200, Pavel Machek wrote:
> Do you have XFS compiled in, by chance?

Yes.

> You are not actually resuming from initrd, right?

That is correct.

-Barry K. Nathan <barryn@pobox.com>
