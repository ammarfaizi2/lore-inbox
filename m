Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTIPAeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTIPAeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:34:31 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:25350 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261699AbTIPAea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:34:30 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Date: Tue, 16 Sep 2003 01:34:22 +0100
User-Agent: KMail/1.5.3
References: <20030910114346.025fdb59.akpm@osdl.org> <63090000.1063303982@flay> <20030911215238.GN12021@suse.de>
In-Reply-To: <20030911215238.GN12021@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309160134.28169.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Sep 2003 22:52, Jens Axboe wrote:
> On Thu, Sep 11 2003, Martin J. Bligh wrote:
> >
> > Symptoms are that it required cdrecord-pro, which was a closed source
> > piece of turd I can't do much with ;-)
>
> Surely the pro version supports open-by-device as well? And then it
> should work fine.

It does.  However it also produces the same error message as cdrecord when 
doing so, ie

Warning: Open by 'devname' is unintentional and not supported.

The implication being that it could go away or become broken at any time.

-- 
Ian.

